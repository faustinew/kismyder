extends Node3D

var scene_root

# var counter = 0
# @export var spawn_every_n_seconds = 1.0
@export var instance_scene: Array[PackedScene]

func _ready() -> void:
	GlobalInput.key_pressed.connect(_on_key_pressed)
	
	scene_root = get_tree().current_scene


# func _process(delta: float) -> void:
# 	counter += 1.0 * delta
# 	if counter >= spawn_every_n_seconds:
# 		spawn_random_instance()
# 		counter = 0.0

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

func _on_key_pressed(key) -> void:
	print("pisse:")
	match key:
		Constants.KEY_VOMI["BEZO"]:
			spawn_instance(instance_scene[0])
			print("bez ")
		Constants.KEY_VOMI["BLOD"]:
			spawn_instance(instance_scene[1])
			print("blodddd")
		Constants.KEY_VOMI["LOGO"]:
			spawn_instance(instance_scene[2])
		Constants.KEY_VOMI["TETE"]:
			spawn_instance(instance_scene[3])
		Constants.KEY_VOMI["TOFF"]:
			spawn_instance(instance_scene[4])
		Constants.KEY_VOMI["ZUCK"]:
			spawn_instance(instance_scene[5])
