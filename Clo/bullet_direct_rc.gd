extends RayCast2D

func _physics_process(delta: float) -> void:
	if (self.is_colliding):
		if (get_collider() != null && get_collider().is_in_group("Wall")):
			handle_bounce()
func handle_bounce():
	var normal = get_collision_normal()
	get_parent().bounce(normal)
