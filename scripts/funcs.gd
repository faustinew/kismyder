extends Node

func randv(r: float) -> Vector3:

    var x = randf_range(-r, r)
    var y = randf_range(-r, r)
    var z = randf_range(-r, r)
    return Vector3(x, y, z)

func randv_fromv(v: Vector3) -> Vector3:
    var x = randf_range(-v.x, v.x)
    var y = randf_range(-v.y, v.y)
    var z = randf_range(-v.z, v.z)
    return Vector3(x, y, z)