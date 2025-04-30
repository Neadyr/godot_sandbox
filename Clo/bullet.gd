extends Area2D
var velocity = Vector2.ZERO
var speed = 30
var lifetime = 2

func _ready():
	self.body_entered.connect(_on_body_entered)
	
func _physics_process(delta):
	print(lifetime)
	lifetime -= delta
	if (lifetime < 0):
		queue_free()
	position += velocity * delta * speed
	queue_redraw()
	$RayCast2D.target_position = velocity.rotated(-rotation).normalized() * 30
func _on_body_entered(body):
	if body.is_in_group("Enemy"):
		body.got_hit(20)
		queue_free()
		

func bounce(normal):
	velocity = velocity.bounce(normal)
	
func _draw():
	if velocity.length() > 0:
		var dir = velocity.rotated(-rotation).normalized()
		var end = dir * 50
		draw_line(Vector2.ZERO, end, Color.ORANGE, 2.0)
		draw_circle(end, 3, Color.RED)
