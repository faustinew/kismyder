extends MeshInstance3D

# label texte pour debug
@onready var label = $Label3D

var chaos_counter = 0

var morph_speed = 16.0

# le launchpad est organisé ainsi
# 13-20
# 29-36
# 49-56
# 77-84

const CC_CHAOS = 20
const CC_HEAD_ROTATION = 13
const CC_HEAD_TILT = 29

# dictionnaire des "Blend shape" = [0: numéro de CC main, 1: numéro de CC du multiplieur, 2: valeur minimum (0 ou -1)]
const SHAPE_DICTIONARY = {
	"Chialz" = [82, 54, -1],
	"Gros nez" = [84, 56, -0.1],
	"Grozieux" = [80, 52, -0.2],
	"Jock" = [-1, 36, -1], # nombre négatif pour garbage CC, je controlerai pas manuellement
	"Joue droite" = [-2, 36, -1],
	"Joue gauche" = [-3, 36, -1],
	"Joues" = [81, 53, -0.5],
	"Lower" = [-4, 36, -0.2],
	"Oneille droite" = [-105, 36, -1], # on gerera les oneilles battantes ailleurs
	"Oneille gauche" = [-106, 36, -1], # donc j'assigne à en dessous de -100
	"Oneilles" = [83, 55, -0.1],
	"Open" = [77, 49, -0.2],
	"Sourcil droit" = [-7, 36, -1],
	"Sourcil gauche" = [-8, 36, -1],
	"Sourcils" = [79, 51, -0.1],
	"Sourire" = [78, 50, -1.0],
	"Upper" = [-9, 36, -0.2]
}

# un multiplieur pour des déformations aléatoires
var chaos = 0.0
var head_rotation = 0.0

var max_head_speed = 500.0

var face_shape = {}

func _ready() -> void:
	GlobalInput.cc_changed.connect(_on_cc_changed)

	# on va transferer toutes les infos dans face_shape et on n'utilisera pas SHAPE_DICTIONARY ensuite
	# la structure est face_shape[cc] = [0: blend shape index, 1: goal (pour le lerp), 2: cc du mult, 3: valeur min, 4: valeur actuelle]
	# (ptet on voudra ajouter valeur actuelle du mult ?)
	for n in SHAPE_DICTIONARY:
		face_shape[SHAPE_DICTIONARY[n][0]] = [find_blend_shape_by_name(n), 0.0, SHAPE_DICTIONARY[n][1], SHAPE_DICTIONARY[n][2], 0.0]


func _process(delta: float) -> void:

	rotation_degrees.y += head_rotation * delta

	label.text = str(chaos)

	chaos_counter += 1
	for n in face_shape:
		if chaos > 0.001 and chaos_counter > randi_range(2, 20):
			if randi() % 5 == 0:
				face_shape[n][1] = 0.0
			else:
				var r = randf_range(-1.0, 1.0) * chaos / 10
				var mult = remap(GlobalInput.cc[face_shape[n][2]], 0, 128, 1, 5)
				face_shape[n][1] += r * mult
			chaos_counter = 0


	for n in face_shape:
		face_shape[n][4] = lerp(face_shape[n][4], face_shape[n][1], delta * morph_speed)
		set_blend_shape_value(face_shape[n][0], face_shape[n][4])

	
# func _unhandled_input(_event: InputEvent) -> void:
# 	for n in SHAPE_DICTIONARY:
# 		var index_main = SHAPE_DICTIONARY[n][0]
# 		var index_mult = SHAPE_DICTIONARY[n][1]
# 		var min_value = SHAPE_DICTIONARY[n][2]
# 		var mult = remap(GlobalInput.cc[index_mult], 0, 128, 1, 10)

# 		set_blend_shape_value(face_shape[index_main], remap(GlobalInput.cc[index_main], 0, 128, min_value, 1.0) * mult)

# 	chaos = log(remap(GlobalInput.cc[chaos_input], 0, 128, 0, 10))
# 	label.text = str(chaos)

func _on_cc_changed(cc_number) -> void:
	match cc_number:
		CC_CHAOS:
			chaos = log(remap(GlobalInput.cc[CC_CHAOS], 0, 128, 0.0, 10.0))
		CC_HEAD_ROTATION:
			head_rotation = remap(GlobalInput.cc[CC_HEAD_ROTATION], 0, 128, -max_head_speed, max_head_speed)
		_:
			if face_shape.has(cc_number):
				var mult = remap(GlobalInput.cc[face_shape[cc_number][2]], 0, 128, 1.0, 10.0)
				var min_value = face_shape[cc_number][3]
				face_shape[cc_number][1] = remap(GlobalInput.cc[cc_number], 0, 128, min_value, 1.0) * mult
