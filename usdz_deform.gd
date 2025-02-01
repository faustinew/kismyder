extends MeshInstance3D

# label texte pour debug
@onready var label = $Label3D

var chaos_counter = 0

var lerp_goal = 0.0

# le launchpad est organisé ainsi
# 13-20
# 29-36
# 49-56
# 77-84

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
	#"Oneille droite" = [-5, 36, -1],   on gerera les oneilles battantes ailleurs
	#"Oneille gauche" = [-6, 36, -1],
	"Oneilles" = [83, 55, -0.1],
	"Open" = [77, 49, 0.0],
	"Sourcil droit" = [-7, 36, -1],
	"Sourcil gauche" = [-8, 36, -1],
	"Sourcils" = [79, 51, -0.1],
	"Sourire" = [78, 50, -1],
	"Upper" = [-9, 36, -0.2]
}

# un multiplieur pour des déformations aléatoires
var chaos = 0.0
var chaos_input = 20 # 20 = le potard en haut à droite

var face_shape = {}

func _ready() -> void:
	# assigne chaque blend shape au numéro de CC qui va la controller
	for n in SHAPE_DICTIONARY:
		var cc_key = SHAPE_DICTIONARY[n][0]
		face_shape[cc_key] = find_blend_shape_by_name(n)
		set_blend_shape_value(face_shape[cc_key], 0.0) # initialiser toutes les blend shapes à zéro


func _process(delta: float) -> void:

	chaos_counter += 1
	if chaos > 0.001 and chaos_counter > 10:
		for n in SHAPE_DICTIONARY:

			var i = SHAPE_DICTIONARY[n][0]
			var v = get_blend_shape_value(face_shape[i])
			var m = remap(GlobalInput.cc[SHAPE_DICTIONARY[n][1]], 0, 128, 1, 10)
			var r = randf_range(-1.0, 1.0) * chaos * m
			lerp_goal = r + v
			chaos_counter = 0
			var lerpy = lerp(v, lerp_goal, delta)
			set_blend_shape_value(face_shape[i], lerpy)
		

func _unhandled_input(_event: InputEvent) -> void:
	for n in SHAPE_DICTIONARY:
		var index_main = SHAPE_DICTIONARY[n][0]
		var index_mult = SHAPE_DICTIONARY[n][1]
		var min_value = SHAPE_DICTIONARY[n][2]
		var mult = remap(GlobalInput.cc[index_mult], 0, 128, 1, 10)

		set_blend_shape_value(face_shape[index_main], remap(GlobalInput.cc[index_main], 0, 128, min_value, 1.0) * mult)

	chaos = log(remap(GlobalInput.cc[chaos_input], 0, 128, 0, 10))
	label.text = str(chaos)
