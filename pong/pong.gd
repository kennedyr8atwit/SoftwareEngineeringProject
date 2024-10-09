extends Node2D

var screen_size
var pad_size
var direction = Vector2(1.0, 0.0)

# Constant for ball speed (in pixels/second)
const INITIAL_BALL_SPEED = 80
# Speed of the ball (also in pixels/second)
var ball_speed = INITIAL_BALL_SPEED
# Constant for pads speed
const PAD_SPEED = 150
#Max ball speed
const MAX_BALL_SPEED = 300

func _ready():
	screen_size = get_viewport_rect().size
	pad_size = get_node("left").get_texture().get_size()
	set_process(true)

func _process(delta):
	_update_ball_position(delta)
	_handle_pad_movement(delta)

func _update_ball_position(delta):
	var ball_pos = get_node("ball").position
	var collision_buffer = 5
	ball_pos += direction * ball_speed * delta

	# Ball collision with top and bottom
	if (ball_pos.y < 0 and direction.y < 0) or (ball_pos.y > screen_size.y and direction.y > 0):
		direction.y = -direction.y

	# Ball collision with paddles
	var left_rect = Rect2(get_node("left").position - pad_size * 0.5 - Vector2(collision_buffer, 0), pad_size + Vector2(collision_buffer * 2, 0))
	var right_rect = Rect2(get_node("right").position - pad_size * 0.5 - Vector2(collision_buffer, 0), pad_size + Vector2(collision_buffer * 2, 0))

	if (left_rect.has_point(ball_pos) and direction.x < 0) or (right_rect.has_point(ball_pos) and direction.x > 0):
		direction.x = -direction.x
		direction.y = randf() * 2.0 - 1
		direction = direction.normalized()
		ball_speed *= 1.1
		
	if ball_speed > MAX_BALL_SPEED:
		ball_speed=MAX_BALL_SPEED

	# Reset the ball if it goes out of bounds
	if ball_pos.x < 0 or ball_pos.x > screen_size.x:
		ball_pos = screen_size * 0.5
		ball_speed = INITIAL_BALL_SPEED
		direction = Vector2(randf() * 2.0 - 1, 0)

	get_node("ball").position=ball_pos

func _handle_pad_movement(delta):
	# Move left pad
	var left_pos = get_node("left").position
	if left_pos.y > 0 and Input.is_action_pressed("left_up"):
		left_pos.y -= PAD_SPEED * delta
	if left_pos.y < screen_size.y and Input.is_action_pressed("left_down"):
		left_pos.y += PAD_SPEED * delta
	get_node("left").position=left_pos

	# Move right pad
	var right_pos = get_node("right").position
	if right_pos.y > 0 and Input.is_action_pressed("right_up"):
		right_pos.y -= PAD_SPEED * delta
	if right_pos.y < screen_size.y and Input.is_action_pressed("right_down"):
		right_pos.y += PAD_SPEED * delta
	get_node("right").position=right_pos
