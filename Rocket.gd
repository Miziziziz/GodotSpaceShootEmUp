extends KinematicBody2D

const MOVE_SPEED = 100
const LIFE_TIME = 5
var cur_life = 0.0
var dir = Vector2.UP
var explosion = preload("res://Explosion.tscn")

func _physics_process(delta):
	var collision = move_and_collide(dir * delta * MOVE_SPEED)
	if collision and collision.collider.has_method("p_kill"):
		collision.collider.p_kill()
		queue_free()
	
	cur_life += delta
	if cur_life > LIFE_TIME:
		queue_free()

func kill():
	var expl = explosion.instance()
	get_tree().get_root().add_child(expl)
	expl.global_position = global_position
	queue_free()