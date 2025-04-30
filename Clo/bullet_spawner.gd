extends Sprite2D


func _physics_process(delta):
	self.look_at(get_viewport().get_mouse_position())
