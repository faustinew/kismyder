extends MeshInstance3D

# label texte pour debug
@onready var label = $Label3D

var chaos_counter = 0

var morph_speed = 16.0


# un multiplieur pour des déformations aléatoires
var chaos = 0.0
var head_rotation = 0.0
var head_tilt = 0.0

var max_head_speed = 500.0

var face_shape = {}

func _ready() -> void:
	GlobalInput.cc_changed.connect(_on_cc_changed)
	GlobalInput.key_pressed.connect(_on_key_pressed)

	# on va transferer toutes les infos dans face_shape et on n'utilisera pas SHAPE_DICTIONARY ensuite
	# la structure est face_shape[cc] = [0: blend shape index, 1: goal (pour le lerp), 2: cc du mult, 3: valeur min, 4: valeur actuelle]
	# (ptet on voudra ajouter valeur actuelle du mult ?)
	for n in Constants.SHAPE_DICTIONARY:
		face_shape[Constants.SHAPE_DICTIONARY[n][0]] = [find_blend_shape_by_name(n), 0.0, Constants.SHAPE_DICTIONARY[n][1], Constants.SHAPE_DICTIONARY[n][2], 0.0]


func _process(delta: float) -> void:

	rotation_degrees.y += head_rotation * delta
	rotation_degrees.x = head_tilt

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

func _on_cc_changed(cc_number) -> void:
	match cc_number:
		Constants.CC_CHAOS:
			chaos = log(remap(GlobalInput.cc[cc_number], 0, 128, 0.0, 10.0))
		Constants.CC_HEAD_ROTATION:
			head_rotation = remap(GlobalInput.cc[cc_number], 0, 128, -max_head_speed, max_head_speed)
		Constants.CC_HEAD_TILT:
			head_tilt = remap(GlobalInput.cc[cc_number], 0, 128, 45.0, -45.0)
		_:
			if face_shape.has(cc_number):
				var mult = remap(GlobalInput.cc[face_shape[cc_number][2]], 0, 128, 1.0, 10.0)
				var min_value = face_shape[cc_number][3]
				face_shape[cc_number][1] = remap(GlobalInput.cc[cc_number], 0, 128, min_value, 1.0) * mult

func _on_key_pressed(key) -> void:
	match key:
		Constants.KEY_RESET:
			for n in face_shape:
				face_shape[n][1] = 0.0
