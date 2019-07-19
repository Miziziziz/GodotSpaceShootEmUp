extends KinematicBody2D

const MOVE_SPEED = 200
const FIRE_RATE = 0.15
var fire_time = 0.0

var laser_bolt = preload("res://LaserBolt.tscn")
var dead = false
var explosion = preload("res://Explosion.tscn")

func _ready():
	add_to_group("player")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _physics_process(delta):
	if dead:
		return
	var move_vec = Vector2()
	if Input.is_action_pressed("move_left"):
		move_vec.x -= 1
	if Input.is_action_pressed("move_right"):
		move_vec.x += 1
	move_and_collide(move_vec * delta * MOVE_SPEED)

func _process(delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	if dead and Input.is_action_just_pressed("restart"):
		get_tree().call_group("delete_on_restart", "queue_free")
		get_tree().reload_current_scene()
	
	if not dead and Input.is_action_pressed("shoot"):
		shoot()


func shoot():
	if get_time() - fire_time < FIRE_RATE:
		return
	fire_time = get_time()
	var las = laser_bolt.instance()
	get_tree().get_root().add_child(las)
	las.global_position = $FirePoint.global_position
	las.scoreboard = $CanvasLayer/ScoreBoard

func get_time():
	return OS.get_ticks_msec() / 1000.0

func p_kill():
	var expl = explosion.instance()
	get_tree().get_root().add_child(expl)
	expl.global_position = global_position
	$Sprite.hide()
	dead = true
	$CanvasLayer/RestartMessage.show()