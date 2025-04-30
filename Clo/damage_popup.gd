extends Node2D
var text = "0"
var velocity = Vector2.ZERO
var speed = 100
var lifespan = 0.80
var offset = Vector2(0, -20)
func _ready():
	$damage_output.text = str(text)
	print("damaaaage", text)
	position = position + offset
func _process(delta):
	print(position)
	lifespan -= delta
	if (lifespan > 0):
		position += Vector2(0, -0.5) * delta * speed
	else:
		queue_free()
