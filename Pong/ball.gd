extends Area2D
var velocity = Vector2(1, 1)
var speed = 200

func _ready():
	position = Vector2(500, 200)
	
func _physics_process(delta):
	position += velocity * delta * speed
	queue_redraw()
	$RayCast2D.target_position = velocity.rotated(-rotation).normalized() * 20
	
func bounce(normal):
	velocity = velocity.bounce(normal)
	
func _draw():
	if velocity.length() > 0:
		var dir = velocity.rotated(-rotation).normalized()
		var end = dir * 20
		draw_line(Vector2.ZERO, end, Color.ORANGE, 2.0)
		draw_circle(end, 3, Color.RED)
