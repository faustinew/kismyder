extends RigidBody3D

@onready var mesh = $MeshInstance3D
@onready var collision_shape = $CollisionShape3D

var speed: float = 5.0
var lifetime = 10.0 + randf() * 5.0
var variation = 0.01
var angle_variation = Vector3(randf_range(-variation, variation), randf_range(-variation, variation), randf_range(-variation, variation))

var target_size
var grow_speed = 3.0

func _ready() -> void:
    var r = randf_range(0.6, 1.1)
    mesh.scale *= Vector3(r, r, r)
    target_size = mesh.scale
    mesh.scale *= 0.2
    collision_shape.scale *= 0.2
    speed *= randf_range(0.5, 2.0)
    apply_central_impulse((get_global_transform().basis.z + angle_variation).normalized() * speed)

func _process(delta: float) -> void:
    lifetime -= delta

    if lifetime > 0 and mesh.scale < target_size:
        mesh.scale *= 1 + grow_speed * delta
        collision_shape.scale *= 1 + grow_speed * delta

    if lifetime < 0:
        mesh.scale *= 0.99
        if mesh.scale.x < 0.1:
            queue_free()
