extends MeshInstance3D

# label texte pour debug
@onready var label = $Label3D

# dictionnaire des "Blend shape" = [0: numéro de CC main, 1: numéro de CC du multiplieur, 2: valeur minimum (0 ou -1)]
const SHAPE_DICTIONARY = {
	"Gros nez" = [77, 49, -0.1],
	"Oneilles" = [78, 50, 0],
	"Open" = [79, 51, -0.5],
	"Grozieux" = [80, 52, -1]

}

# un multiplieur pour des déformations aléatoires
var chaos = 0.0
var chaos_input = 20 # 20 = le potard en haut à droite

var face_shape = []

func _ready() -> void:
	face_shape.resize(128)

	# assigne chaque blend shape au numéro de CC qui va la controller
	for n in SHAPE_DICTIONARY:
		face_shape.insert(SHAPE_DICTIONARY[n][0], find_blend_shape_by_name(n))


func _process(delta: float) -> void:
	if chaos > 0.001:
		for n in SHAPE_DICTIONARY:
			var i = SHAPE_DICTIONARY[n][0]
			var m = remap(GlobalInput.cc[SHAPE_DICTIONARY[n][1]], 0, 128, 1, 10)
			var v = get_blend_shape_value(face_shape[i])
			var r = randf_range(-1.0, 1.0) * chaos * m * delta
		
			set_blend_shape_value(face_shape[i], clamp(v + r, -1 * m, 1 * m))
		

func _unhandled_input(event: InputEvent) -> void:
	for n in SHAPE_DICTIONARY:
		var index_main = SHAPE_DICTIONARY[n][0]
		var index_mult = SHAPE_DICTIONARY[n][1]
		var min_value = SHAPE_DICTIONARY[n][2]
		var mult = remap(GlobalInput.cc[index_mult], 0, 128, 1, 10)
		set_blend_shape_value(face_shape[index_main], remap(GlobalInput.cc[index_main], 0, 128, min_value, 1.0) * mult)

	chaos = log(remap(GlobalInput.cc[chaos_input], 0, 128, 0, 10))
	label.text = str(chaos)