extends KinematicBody2D

const MOVE_SPEED = 400
const LIFE_TIME = 5
var cur_life = 0.0
var scoreboard = null

func _physics_process(delta):
	var collision = move_and_collide(Vector2.UP * delta * MOVE_SPEED)
	if collision and collision.collider.has_method("kill"):
		collision.collider.kill()
		queue_free()
		scoreboard.add_point()
	
	cur_life += delta
	if cur_life > LIFE_TIME:
		queue_free()