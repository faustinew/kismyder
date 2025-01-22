extends Node3D

var counter = 0
@export var spawn_every_n_seconds = 1.0
@export var instance_scene: PackedScene

@export var spawn_position_variance_x = 0.0
@export var spawn_position_variance_y = 0.0
@export var spawn_position_variance_z = 0.0

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	counter += 1.0 * delta
	if counter >= spawn_every_n_seconds:
		spawn_instance()
		counter = 0.0

func spawn_instance() -> void:
	var instance = instance_scene.instantiate()
	var spawn_x = randf() * spawn_position_variance_x - spawn_position_variance_x / 2
	var spawn_y = randf() * spawn_position_variance_y - spawn_position_variance_y / 2
	var spawn_z = randf() * spawn_position_variance_z - spawn_position_variance_z / 2
	instance.position = Vector3(spawn_x, spawn_y, spawn_z)
	add_child(instance)
