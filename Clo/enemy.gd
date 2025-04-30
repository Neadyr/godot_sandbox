extends CharacterBody2D
var speed = 5
var max_life = 100
var life = max_life
var is_bumped = false
var got_bumped = false
var bumped_strength = Vector2.ZERO
var bump_decrease_speed = 15

func _physics_process(delta):
	var bump_power = 15 + (max_life - life) / 10
	var collision = move_and_collide(velocity * delta)
	if collision:
		var obj = collision.get_collider()
	var player = get_node('../Player')
	var direction = Vector2(player.position - self.position).normalized() * delta
	if (got_bumped):
		bumped_strength = direction.normalized() * - bump_power
		got_bumped = false
	if (is_bumped):
		bumped_strength = bumped_strength.lerp(Vector2.ZERO, bump_decrease_speed * delta)
		if bumped_strength.length() < 2:
			bumped_strength = Vector2.ZERO
			is_bumped = false
	velocity = direction.normalized() * speed + bumped_strength
	move_and_collide(velocity)
	
func got_hit(amount: int) -> void:
	is_bumped = true
	got_bumped = true
	life -= amount
	if (life <= 0):
		print('dead')
		queue_free()
