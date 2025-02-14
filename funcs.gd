extends Node

func randv(r) -> Vector3:
    var x = randf_range(-r, r)
    var y = randf_range(-r, r)
    var z = randf_range(-r, r)
    return Vector3(x, y, z)