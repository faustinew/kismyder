extends Node3D

var scene_root

var counter = 0
@export var spawn_every_n_seconds = 1.0
@export var instance_scene: Array[PackedScene]

func _ready() -> void:
	scene_root = get_tree().current_scene


func _process(delta: float) -> void:
	counter += 1.0 * delta
	if counter >= spawn_every_n_seconds:
		spawn_instance()
		counter = 0.0

func spawn_instance() -> void:
	var instance = instance_scene.pick_random().instantiate()
	instance.rotation = global_rotation
	instance.position = global_position
	scene_root.add_child(instance)
