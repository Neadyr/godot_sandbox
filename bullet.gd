extends Area2D
var velocity = Vector2.ZERO
var speed = 30

func _ready():
	self.body_entered.connect(_on_body_entered)
func _physics_process(delta):
	position += velocity * delta * speed

func _on_body_entered(body):
	print("bullet collided with :" , body)
	if body.is_in_group("Enemy"):
		body.got_hit(20)
		queue_free()
