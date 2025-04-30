extends Sprite2D

@export var bullet_scene: PackedScene
var bullet_cooldown = 0.1
var bullet_timer = 0

func _physics_process(delta):
	if (bullet_timer >= 0):
		bullet_timer -= delta
	if (Input.is_action_pressed("tir")):
		if (bullet_timer < 0):
			var bullet = bullet_scene.instantiate()
			bullet.global_position = self.global_position
			bullet.velocity = (get_viewport().get_mouse_position() - self.global_position).normalized() * bullet.speed
			bullet.rotation = bullet.velocity.angle()
			get_parent().get_parent().get_parent().add_child(bullet)
			bullet_timer = bullet_cooldown
