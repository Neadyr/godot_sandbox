extends Area2D
var velocity = Vector2.ZERO
var speed = 30
var lifetime = 2
var damage = 20
var bullet_life = 20
signal enemy_hit

func _ready():
	self.body_entered.connect(_on_body_entered)
	
func _physics_process(delta):
	lifetime -= delta
	if (lifetime < 0):
		queue_free()
	position += velocity * delta * speed
	queue_redraw()
	$RayCast2D.target_position = velocity.rotated(-rotation).normalized() * 20
	
func _on_body_entered(body):
	if body.is_in_group("Enemy"):
		body.got_hit(damage)
		bullet_life -= damage
		emit_signal("enemy_hit", damage, body.global_position)
		if (bullet_life <= 0):
			queue_free()
		
func bounce(normal):
	velocity = velocity.bounce(normal)
	
func _draw():
	if velocity.length() > 0:
		var dir = velocity.rotated(-rotation).normalized()
		var end = dir * 20
		draw_line(Vector2.ZERO, end, Color.ORANGE, 2.0)
		draw_circle(end, 3, Color.RED)
