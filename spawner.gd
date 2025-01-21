extends Node3D

var counter = 0
@export var spawn_every_n_seconds = 1.0
@export var instance_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	counter += 1.0 * delta
	if counter >= spawn_every_n_seconds:
		spawn_instance()
		counter = 0.0

func spawn_instance() -> void:
	var instance = instance_scene.instantiate()
	instance.position = Vector3(randf_range(-10.0, 10.0), randf_range(-10.0, 10.0), randf_range(-10.0, 10.0))
	add_child(instance)
