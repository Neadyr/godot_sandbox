extends Node2D
var rng = RandomNumberGenerator.new()

@export var enemy_scene: PackedScene
var number_of_enemy = 500
var kill_count = 0
var score = 0

func _ready():
	print("game started")
	rng.randomize()
	generate_wave()

func _process(_delta):
	$Player/Camera2D/monster_count.text = 'Wave 01 : %d / %d' %[kill_count, number_of_enemy]
	$"Player/Camera2D/score".text = '%d points' %score
	
func generate_wave():
	for i in range(number_of_enemy):
		var enemy = enemy_scene.instantiate()
		enemy.died.connect(increase_kill_count)
		enemy.position = await generate_random_location()
		enemy.name = "Enemy %d" %rng.randi()
		add_child(enemy)
		
func increase_kill_count():
	kill_count += 1
	score += 50
	
func generate_random_location():
	var player_pos = $Player.position
	var x = rng.randi_range(-2000, 2000)
	var y = rng.randi_range(-2000, 2000)
	if (player_pos.distance_to(Vector2(x, y)) < 500):
		generate_random_location()
	await get_tree().create_timer(1).timeout
	return Vector2(x, y)
