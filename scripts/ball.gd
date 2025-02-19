extends RigidBody3D

var mesh_size = 1.0
var max_mesh_size

var repulsion_force = 5.0


func _ready() -> void:
	apply_impulse(random_vector3(), random_vector3())
	#apply_torque_impulse(random_vector3()) ça marche pas je sais pas pourquoi

	#met la taille à 0.1 pour faire un effet de spawn en grossissant
	max_mesh_size = mesh_size
	mesh_size = 0.1
	$Mesh.scale = Vector3(mesh_size, mesh_size, mesh_size)


func _process(delta: float) -> void:

	#on fait grossir jusqu'à var size
	if mesh_size < max_mesh_size:
		mesh_size += 10 * delta
	$Mesh.scale = Vector3(mesh_size, mesh_size, mesh_size)


	var neighbours = $OuterArea.get_overlapping_bodies()
	if not neighbours.is_empty():
		for neighbour in neighbours:
			neighbour.apply_force(position.direction_to(neighbour.position) * repulsion_force)

func random_vector3() -> Vector3:
	var result = Vector3(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized()
	return result
