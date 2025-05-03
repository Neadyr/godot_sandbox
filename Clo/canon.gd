extends Sprite2D
@export var damagepop_scene: PackedScene
@export var bullet_scene: PackedScene
var bullet_cooldown = 0.1
var bullet_timer = 0
var max_load = 5
var current_load = 1
var is_loading = false
func _physics_process(delta):
	if (bullet_timer >= 0):
		bullet_timer -= delta
	if (is_loading && current_load <= max_load):
		current_load += delta
	if (Input.is_action_pressed("shot") && !is_loading):
		if (bullet_timer < 0):
			var bullet = bullet_scene.instantiate()
			bullet.enemy_hit.connect(generate_damage_label)
			bullet.global_position = self.global_position
			bullet.velocity = (get_global_mouse_position() - self.global_position).normalized() * bullet.speed
			bullet.rotation = bullet.velocity.angle()
			get_parent().get_parent().get_parent().add_child(bullet)
			bullet_timer = bullet_cooldown
	if (Input.is_action_just_pressed("loaded_shot")):
			is_loading = true
	if (Input.is_action_just_released("loaded_shot")):
			is_loading = false
			var bullet = bullet_scene.instantiate()
			bullet.global_position = self.global_position
			bullet.enemy_hit.connect(generate_damage_label)
			bullet.velocity = (get_global_mouse_position() - self.global_position).normalized() * bullet.speed * 1.5
			bullet.rotation = bullet.velocity.angle()
			bullet.scale = Vector2(current_load, current_load)
			bullet.damage = bullet.damage * current_load
			bullet.bullet_life = bullet.damage * current_load
			get_tree().current_scene.add_child(bullet)
			bullet_timer = bullet_cooldown
			current_load = 1
	
func generate_damage_label(amount, spawn_position):
	var popup = damagepop_scene.instantiate()
	popup.position = spawn_position
	popup.text = amount
	get_tree().current_scene.add_child(popup)
