extends Node3D

var scene_root

var vbezo = false
var vblod = false
var vtete = false
var vtoff = false
var vzuck = false
var vsgli = false

var counter = 0
@export var spawn_every_n_seconds = 0.05
@export var instance_scene: Array[PackedScene]

func _ready() -> void:
	GlobalInput.key_pressed.connect(_on_key_pressed)
	GlobalInput.key_released.connect(_on_key_released)
	
	scene_root = get_tree().current_scene


# func _process(delta: float) -> void:
# 	counter += 1.0 * delta
# 	if counter >= spawn_every_n_seconds:
# 		spawn_random_instance()
# 		counter = 0.0

func _process(delta: float) -> void:

	counter += 1.0 * delta
	if counter >= spawn_every_n_seconds:
		if vbezo:
			spawn_instance(instance_scene[0])
		if vblod:
			spawn_instance(instance_scene[1])
		if vtete:
			spawn_instance(instance_scene[3])
		if vtoff:
			spawn_instance(instance_scene[4])
		if vzuck:
			spawn_instance(instance_scene[5])
		if vsgli:
			spawn_instance(instance_scene[6])


func spawn_random_instance() -> void:
	var instance = instance_scene.pick_random().instantiate()
	instance.rotation = global_rotation
	instance.position = global_position
	scene_root.add_child(instance)

func spawn_instance(scene) -> void:
	var instance = scene.instantiate()
	instance.rotation = global_rotation
	instance.position = global_position
	scene_root.add_child(instance)
	counter = 0.0

func _on_key_pressed(key) -> void:
	match key:
		Constants.KEY_VOMI["BEZO"]:
			vbezo = true
		Constants.KEY_VOMI["BLOD"]:
			vblod = true
		Constants.KEY_VOMI["LOGO"]:
			spawn_instance(instance_scene[2])
		Constants.KEY_VOMI["TETE"]:
			vtete = true
		Constants.KEY_VOMI["TOFF"]:
			vtoff = true
		Constants.KEY_VOMI["ZUCK"]:
			vzuck = true
		Constants.KEY_VOMI["SGLI"]:
			vsgli = true
			
func _on_key_released(key) -> void:
	match key:
		Constants.KEY_VOMI["BEZO"]:
			vbezo = false
		Constants.KEY_VOMI["BLOD"]:
			vblod = false
		Constants.KEY_VOMI["TETE"]:
			vtete = false
		Constants.KEY_VOMI["TOFF"]:
			vtoff = false
		Constants.KEY_VOMI["ZUCK"]:
			vzuck = false
		Constants.KEY_VOMI["SGLI"]:
			vsgli = false
