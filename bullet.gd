extends Area2D
var velocity = Vector2.ZERO
var speed = 50
func _ready():
	print("Nouvelle balle avec vitesse :", velocity)

func _physics_process(delta):
	position += velocity * delta * speed
