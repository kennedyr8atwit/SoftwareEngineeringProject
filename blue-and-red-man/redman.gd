extends CharacterBody2D

const acc = 1500  
const m_speed = 400  
const friction = 600  
const grav = 20  
const j_force = -900  

func _physics_process(delta):
	player_movement(delta)

func player_movement(delta):
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += acc * delta
		$red.play("run")  
		$red.flip_h = false  
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= acc * delta
		$red.play("run")  
		$red.flip_h = true  
	else:
		
		if abs(velocity.x) > friction * delta:
			velocity.x -= friction * delta * sign(velocity.x)
		else:
			velocity.x = 0
			$red.stop() 
			

	
	velocity.x = clamp(velocity.x, -m_speed, m_speed)

	
	velocity.y += grav

	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = j_force
		$red.play("jump")
	
	if not is_on_floor():
		if velocity.y < 0:
			$red.play("jump")
		
		elif velocity.y > 0:
			$red.play("jump_fall")
	
	if is_on_floor() and velocity.x ==0 :
		$red.play("idle")
			
			

	# Move the character with the updated velocity
	move_and_slide()
