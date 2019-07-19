extends KinematicBody2D

var move_speed = 250
var fire_rate = 1.0
var cur_fire_time = 0.0

var explosion = preload("res://Explosion.tscn")
var rocket = preload("res://Rocket.tscn")

func _physics_process(delta):
	var collision = move_and_collide(Vector2.DOWN * delta * move_speed)
	
	if collision and collision.collider.has_method("p_kill"):
		collision.collider.p_kill()

func _process(delta):
	cur_fire_time += delta
	if cur_fire_time > fire_rate:
		cur_fire_time = 0
		fire()
		

func kill():
	var expl = explosion.instance()
	get_tree().get_root().add_child(expl)
	expl.global_position = global_position
	queue_free()

func fire():
	if get_player().global_position.y < global_position.y - 40:
		return
	var roc = rocket.instance()
	roc.add_to_group("delete_on_restart")
	get_tree().get_root().add_child(roc)
	roc.global_position = global_position
	var dir = (get_player().global_position - global_position).normalized()
	roc.dir = dir
	roc.global_rotation = dir.angle() + PI / 2.0

func get_player():
	return get_tree().get_nodes_in_group("player")[0]