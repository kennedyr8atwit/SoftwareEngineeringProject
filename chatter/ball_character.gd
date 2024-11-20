extends CharacterBody2D

const SPEED := 5.0
var score1_count = 0
var score2_count = 0
var initial_position = Vector2(0, 0)  

var left_score_position = Vector2(400, 50)  
var right_score_position = Vector2(700, 50)  


var left_score_label : Label
var right_score_label : Label

func _ready() -> void:
	
	left_score_label = get_node("/root/pong/Border/LeftScore") as Label
	right_score_label = get_node("/root/pong/Border/RightScore") as Label
	

	if left_score_label == null:
		print("LeftScore node not found!")
	else:
		left_score_label.position = left_score_position

	if right_score_label == null:
		print("RightScore node not found!")
	else:
		right_score_label.position = right_score_position

	
	velocity = Vector2(-SPEED, 0)
	update_scores()  
	position = initial_position  

func _physics_process(delta: float) -> void:
	var col: KinematicCollision2D = move_and_collide(velocity)
	if col:
		var normal := col.get_normal()
		velocity = velocity.bounce(normal)
	
	
	if position.x < -575:  
		increase_score(1)  
		reset_ball()
	elif position.x > 575:
		increase_score(2)
		reset_ball()


func update_scores():
	if left_score_label != null:
		left_score_label.text = str(score1_count) 
	if right_score_label != null:
		right_score_label.text = str(score2_count) 


func increase_score(player: int):
	if player == 1:
		score2_count += 1  
	elif player == 2:
		score1_count += 1  
	update_scores() 


func reset_ball():
	position = initial_position
	velocity = Vector2(-SPEED, 0) 
