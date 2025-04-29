extends CharacterBody2D
var speed = 0
var life = 100

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		var obj = collision.get_collider()
		print("Collided with :", obj.is_in_group("Player"))
	var player = get_node('../Player')
	var direction = Vector2(player.position - self.position).normalized() * delta
	
	velocity = direction.normalized() * speed
	move_and_collide(velocity)

func got_hit(amount: int) -> void:
	life -= amount
	if (life <= 0):
		print('dead')
		queue_free()
	print("aie...")
