extends KinematicBody2D

var move_speed = 250

var explosion = preload("res://Explosion.tscn")

func _physics_process(delta):
	var collision = move_and_collide(Vector2.DOWN * delta * move_speed)
	
	if collision and collision.collider.has_method("p_kill"):
		collision.collider.p_kill()

func kill():
	var expl = explosion.instance()
	get_tree().get_root().add_child(expl)
	expl.global_position = global_position
	queue_free()