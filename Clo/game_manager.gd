extends Node2D
var rng = RandomNumberGenerator.new()

@export var enemy_scene: PackedScene

func _ready():
	print("game started")
	rng.randomize()
	generate_wave()

func generate_wave():
	var number_of_enemy = 15
	
	for i in range(number_of_enemy):
		var enemy = enemy_scene.instantiate()
		enemy.position = generate_random_location()
		add_child(enemy)
	
func generate_random_location():
	var window_size = get_viewport().get_visible_rect().size
	var player_pos = $Player.position
	
	var x = rng.randi_range(window_size.x, window_size.x * 2)
	var y = rng.randi_range(window_size.y, window_size.y * 2)
	print(player_pos.distance_to(Vector2(x, y)))
	if (player_pos.distance_to(Vector2(x, y)) < 500):
		generate_random_location()
	return Vector2(x, y)
