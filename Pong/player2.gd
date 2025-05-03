extends CharacterBody2D
var dash_velocity = Vector2.ZERO
var is_dashing = false
var dash_cooldown = 1
var dash_current_timer = 0

func _physics_process(delta: float) -> void:
	#var mouse_position: Vector2 = get_viewport().get_mouse_position()

	if (dash_current_timer >= 0):
		dash_current_timer -= delta
	var dash_strength = 3000
	var dash_friction = 15
	var direction = Vector2.ZERO
	var speed: float = 300

	if (Input.is_action_pressed("player2_up")):
		direction.y -= 1
	if (Input.is_action_pressed("player2_down")):
		direction.y += 1
		
	
	if (dash_current_timer <= 0):
		if (Input.is_action_just_pressed("player2_dash")):
			is_dashing = true
			dash_velocity = direction.normalized() * dash_strength
			dash_current_timer = dash_cooldown
	if (is_dashing):
		dash_velocity = dash_velocity.lerp(Vector2.ZERO, dash_friction * delta)
		if dash_velocity.length() < 2:
			dash_velocity = Vector2.ZERO
			is_dashing = false
	velocity = direction.normalized() * speed + dash_velocity 
	move_and_slide()
