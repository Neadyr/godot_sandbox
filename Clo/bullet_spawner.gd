extends Sprite2D

func _physics_process(_delta):
	self.look_at(get_global_mouse_position())
