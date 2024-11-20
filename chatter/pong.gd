extends Node2D

var screen_size
var pad_size
var direction = Vector2(1.0, 0.0)  # Initial direction of the ball

# Constants for game
const INITIAL_BALL_SPEED = 220
var ball_speed = INITIAL_BALL_SPEED
const PAD_SPEED = 200
const MAX_BALL_SPEED = 350

func _ready():
	screen_size = get_viewport_rect().size
	pad_size = get_node("LeftBody/left") 
	set_process(true)


func _process(delta):
	_handle_pad_movement(delta)


func _handle_pad_movement(delta):
	# Move left paddle
	var left_paddle = get_node("LeftBody")
	var left_pos = left_paddle.position
	if Input.is_action_pressed("left_up") and left_pos.y > -200:
		left_pos.y -= PAD_SPEED * delta
	if Input.is_action_pressed("left_down") and left_pos.y < 250:
		left_pos.y += PAD_SPEED * delta
	left_paddle.position = left_pos

	# Move right paddle
	var right_paddle = get_node("RightBody")
	var right_pos = right_paddle.position
	if Input.is_action_pressed("right_up") and right_pos.y > -200:
		right_pos.y -= PAD_SPEED * delta
	if Input.is_action_pressed("right_down") and right_pos.y < 250:
		right_pos.y += PAD_SPEED * delta
	right_paddle.position = right_pos
