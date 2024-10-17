extends Node2D

var screen_size
var pad_size
var direction = Vector2(1.0, 0.0)
var score1=0
var score2=0

# Constant for ball speed (in pixels/second)
const INITIAL_BALL_SPEED = 120
# Speed of the ball (also in pixels/second)
var ball_speed = INITIAL_BALL_SPEED
# Constant for pads speed
const PAD_SPEED = 200
#Max ball speed
const MAX_BALL_SPEED = 350

func _ready():
	screen_size = get_viewport_rect().size
	pad_size = get_node("left").get_texture().get_size()
	$LeftScore.text = str(score1)
	$RightScore.text = str(score2)
	set_process(true)

func _process(delta):
	
	
	_update_ball_position(delta)
	_handle_pad_movement(delta)

func _update_ball_position(delta):
	var ball_pos = get_node("ball").position
	ball_pos += direction * ball_speed * delta

	# Ball collision with top and bottom
	if (ball_pos.y < 20) or (ball_pos.y > 610):
		direction.y = -direction.y
	
	# Ball collision with paddles
	var left_rect = Rect2(get_node("left").position - pad_size * 0.5, pad_size)
	var right_rect = Rect2(get_node("right").position - pad_size * 0.5, pad_size)

	if (left_rect.has_point(ball_pos) and direction.x < 0) or (right_rect.has_point(ball_pos) and direction.x > 0):
		direction.x = -direction.x
		direction.y = randf() * 2.0 - 1
		direction = direction.normalized()
		ball_speed *= 1.2
		
	if ball_speed > MAX_BALL_SPEED:
		ball_speed = MAX_BALL_SPEED

	# Reset the ball if it goes out of bounds
	if ball_pos.x < 0:
		ball_pos = screen_size * 0.5
		#ball_speed = INITIAL_BALL_SPEED
		score1 += 1
		$LeftScore.text = str(score1)
		direction = Vector2(randf() * 2.0 - 1, 0)
		
	if ball_pos.x > screen_size.x:
		ball_pos = screen_size * 0.5
		ball_speed = INITIAL_BALL_SPEED
		score2 += 1
		$RightScore.text = str(score2)
		direction = Vector2(randf() * 2.0 - 1, 0)

	get_node("ball").position = ball_pos

func _handle_pad_movement(delta):
	#move left paddle
	var left_paddle = get_node("left")
	var left_pos = left_paddle.position

	# Move the paddle up
	if Input.is_action_pressed("left_up") and left_pos.y > 40:
		left_pos.y -= PAD_SPEED * delta

	# Move the paddle down
	if Input.is_action_pressed("left_down") and left_pos.y < 510:
		left_pos.y += PAD_SPEED * delta

	# Set the new position
	left_paddle.position = left_pos

	#move right paddle
	var right_paddle = get_node("right")
	var right_pos = right_paddle.position

	# Move the paddle up
	if Input.is_action_pressed("right_up") and right_pos.y > 40:
		right_pos.y -= PAD_SPEED * delta

	# Move the paddle down
	if Input.is_action_pressed("right_down") and right_pos.y < 510:
		right_pos.y += PAD_SPEED * delta

	# Set the new position
	right_paddle.position = right_pos
	
func increase_score(amount):
	score1 += amount
	$LeftScore.text = str(score1)
