extends RayCast2D

func _physics_process(_delta: float) -> void:
	self.target_position = get_parent().velocity.normalized() * 20
	self.position = Vector2.ZERO
	
	if (self.is_colliding()):
		print(get_collider())
		if (get_collider() != null && get_collider().is_in_group("Wall")):
			print('Wall')
			
			handle_bounce()
		if (get_collider() != null && get_collider().is_in_group("Player")):
			print('Player')
			handle_bounce()
func handle_bounce():
	var normal = get_collision_normal()
	get_parent().bounce(normal)
