extends Sprite2D

func _ready():
	self.modulate = Color.CORAL

func _process(_delta):
	print($"..".current_stamina)
	if $"..".current_stamina == 100:
		self.visible = false
	else:
		self.visible = true
	self.scale = Vector2($"..".current_stamina / 3, 5 )
