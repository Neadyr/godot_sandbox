extends CharacterBody2D
var dash_velocity = Vector2.ZERO
var is_dashing = false
var dash_cooldown = 5
var dash_current_timer = 0
var stamina_max = 100
var current_stamina = stamina_max

func _physics_process(delta: float) -> void:
	print(dash_current_timer)
	if (dash_current_timer >= 0):
		dash_current_timer -= delta
	var dash_strength = 3000
	var dash_friction = 15
	
	var direction = Vector2.ZERO
	var dash_multiplier: int = 1
	var speed: float = 300
	var sprint_speed: float = 1

	if (Input.is_action_pressed("ui_right")):
		direction.x += 1
	if (Input.is_action_pressed("ui_left")):
		direction.x -= 1
	if (Input.is_action_pressed("ui_up")):
		direction.y -= 1
	if (Input.is_action_pressed("ui_down")):
		direction.y += 1
	if (Input.is_action_pressed("sprint")):
		sprint_speed = 1.5
	if (dash_current_timer <= 0):
		if (Input.is_action_just_pressed("dash")):
			print("dash")
			is_dashing = true
			dash_velocity = direction.normalized() * dash_strength
			dash_current_timer = dash_cooldown
		
	if (is_dashing):
		dash_velocity = dash_velocity.lerp(Vector2.ZERO, dash_friction * delta)

		if dash_velocity.length() < 2:
			dash_velocity = Vector2.ZERO
			is_dashing = false
	print("dash_velocity", dash_velocity)
	velocity = direction.normalized() * speed * sprint_speed + dash_velocity 
	move_and_slide()
