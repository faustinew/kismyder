extends Node3D

@onready var light1 = $Light1
@onready var light2 = $Light2
@onready var light3 = $Light3

var lights_rotation = 0.0
var lights_rotation_speed = 10.0

var col_initial_h = [
	0.0,
	0.2,
	0.5
]

var col = [
	Color.from_hsv(0.0, 0.25, 1.0),
	Color.from_hsv(0.2, 0.25, 1.0),
	Color.from_hsv(0.5, 0.25, 1.0)
]

func _ready() -> void:
	GlobalInput.cc_changed.connect(_on_cc_changed)
	GlobalInput.key_pressed.connect(_on_key_pressed)

func _process(delta: float) -> void:
	rotation.y += lights_rotation * lights_rotation_speed * delta

	light1.light_color = col[0]
	light2.light_color = col[1]
	light3.light_color = col[2]

func _on_cc_changed(cc_number) -> void:
	match cc_number:
		Constants.CC_LIGHT1_INTENSITY:
			light1.light_energy = remap(GlobalInput.cc[cc_number], 0, 128, 0.0, 3.0)
		Constants.CC_LIGHT2_INTENSITY:
			light2.light_energy = remap(GlobalInput.cc[cc_number], 0, 128, 0.0, 3.0)
		Constants.CC_LIGHT3_INTENSITY:
			light3.light_energy = remap(GlobalInput.cc[cc_number], 0, 128, 0.0, 3.0)
		Constants.CC_LIGHT1_SAT:
			col[0].s = remap(GlobalInput.cc[cc_number], 0, 128, 0.0, 1.0)
		Constants.CC_LIGHT2_SAT:
			col[1].s = remap(GlobalInput.cc[cc_number], 0, 128, 0.0, 1.0)
		Constants.CC_LIGHT3_SAT:
			col[2].s = remap(GlobalInput.cc[cc_number], 0, 128, 0.0, 1.0)
		Constants.CC_LIGHTS_HUE:
			for n in col.size():
				col[n].h = col_initial_h[n] + remap(GlobalInput.cc[cc_number], 0, 128, 0.0, 1.0)
		Constants.CC_LIGHTS_ROT:
			lights_rotation = remap(GlobalInput.cc[cc_number], 0, 128, -1.0, 1.0)
		Constants.CC_LIGHTS_ROT_MULT:
			lights_rotation_speed = remap(GlobalInput.cc[cc_number], 0, 128, 4.0, 80.0)

func _on_key_pressed(key) -> void:
	pass
