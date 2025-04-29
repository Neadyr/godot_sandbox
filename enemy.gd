extends CharacterBody2D
var speed = 150
func _physics_process(delta):
	var player = get_node('../Player')
	var direction = Vector2(player.position - self.position).normalized() * delta
	print(player.position)
	
	velocity = direction.normalized() * speed
	move_and_slide()
