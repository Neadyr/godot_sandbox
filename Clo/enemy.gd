extends CharacterBody2D
var speed = 100
var max_life = 100
var life = max_life
var is_bumped = false
var got_bumped = false
var bumped_strength = Vector2.ZERO
var bump_decrease_speed = 15
var attack_value = 100

signal died


func _physics_process(delta):
	var bump_power = 500 + (max_life - life)
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
	move_and_slide()
	
func got_hit(amount: int) -> void:
	is_bumped = true
	got_bumped = true
	life -= amount
	if (life <= 0):
		emit_signal("died")
		queue_free()
		
func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.got_hit(attack_value)
