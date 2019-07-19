extends Node2D

var start_spawn_rate = 2.0
var end_spawn_rate = 0.3
var cur_spawn_rate = start_spawn_rate
var time_till_max_difficulty = 30.0
var spawn_time = 0.0
var game_time = 0.0

onready var spawn_points = $SpawnPoints.get_children()

var ram_ship = preload("res://RamShip.tscn")
var rocket_ship = preload("res://RocketShip.tscn")

func _process(delta):
	game_time += delta
	var t = clamp(game_time / time_till_max_difficulty, 0.0, 1.0)
	cur_spawn_rate = lerp(start_spawn_rate, end_spawn_rate, t)
	
	spawn_time += delta
	if spawn_time > cur_spawn_rate:
		spawn_time = 0.0
		spawn()

func spawn():
	for spawn_point in spawn_points:
		if randi() % 2 == 0:
			var ship = null
			if randi() % 2 == 0:
				ship = ram_ship.instance()
			else:
				ship = rocket_ship.instance()
			get_tree().get_root().add_child(ship)
			ship.add_to_group("delete_on_restart")
			ship.global_position = spawn_point.global_position
	
	