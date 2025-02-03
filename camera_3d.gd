extends Camera3D


var zoom
var dolly

var initial_zoom
var initial_dolly

var lerp_speed = 8.0


func _ready() -> void:
	GlobalInput.cc_changed.connect(_on_cc_changed)
	GlobalInput.key_pressed.connect(_on_key_pressed)

	initial_zoom = fov
	zoom = initial_zoom
	initial_dolly = position.z
	dolly = initial_dolly

func _process(delta: float) -> void:
	fov = lerp(fov, zoom, lerp_speed * delta)
	position.z = lerp(position.z, dolly, lerp_speed * delta)


func _on_cc_changed(cc_number) -> void:
	match cc_number:
		Constants.CC_CAMERA_ZOOM:
			zoom = initial_zoom + remap(GlobalInput.cc[cc_number], 0, 128, 40.0, -40.0)
		Constants.CC_CAMERA_DOLLY:
			dolly = initial_dolly + remap(GlobalInput.cc[cc_number], 0, 128, 64.0, -64.0)

func _on_key_pressed(key) -> void:
	match key:
		Constants.KEY_CAM_DEFAULT:
			zoom = 40.0
			dolly = 16.0
		Constants.KEY_CAM_FISHEYE:
			zoom = 140.0
			dolly = 4.0
		Constants.KEY_CAM_FLATTEN:
			zoom = 1.0
			dolly = 540.0
