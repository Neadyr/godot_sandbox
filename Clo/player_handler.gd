extends CharacterBody2D
var dash_velocity = Vector2.ZERO
var is_dashing = false
var dash_cooldown = 1
var dash_current_timer = 0
var stamina_max = 100
var current_stamina = stamina_max
var is_sprinting = false
var sprint_speed: float = 1

func _physics_process(delta: float) -> void:
	#var mouse_position: Vector2 = get_viewport().get_mouse_position()

	if (dash_current_timer >= 0):
		dash_current_timer -= delta
	var dash_strength = 3000
	var dash_friction = 15
	var direction = Vector2.ZERO
	var speed: float = 300
	if (Input.is_action_pressed("ui_right")):
		direction.x += 1
	if (Input.is_action_pressed("ui_left")):
		direction.x -= 1
	if (Input.is_action_pressed("ui_up")):
		direction.y -= 1
	if (Input.is_action_pressed("ui_down")):
		direction.y += 1
	if (Input.is_action_just_released("sprint")):
		is_sprinting = false
	if (Input.is_action_just_pressed("sprint")):
		is_sprinting = true
		
	if (is_sprinting && current_stamina > 0 ):
			sprint_speed = 1.5
			current_stamina -= delta * 10
	else:
		is_sprinting = false
		if (current_stamina < 100):
			sprint_speed = 1
			current_stamina += delta * 10
	if (dash_current_timer <= 0):
		if (Input.is_action_just_pressed("dash")):
			is_dashing = true
			dash_velocity = direction.normalized() * dash_strength
			dash_current_timer = dash_cooldown
	if (is_dashing):
		dash_velocity = dash_velocity.lerp(Vector2.ZERO, dash_friction * delta)
		if dash_velocity.length() < 2:
			dash_velocity = Vector2.ZERO
			is_dashing = false
	velocity = direction.normalized() * speed * sprint_speed + dash_velocity 
	move_and_slide()
