extends CharacterBody2D  

@export var direction: int = -1 

func _ready() -> void:
	if direction == 1:
		$AnimatedSprite2D.flip_h = true

	$floor_check.position.x = abs($CollisionShape2D.shape.get_size().x / 2) * direction

func _physics_process(delta: float) -> void:
	if is_on_wall() or not $floor_check.is_colliding():
		direction = -direction
		$AnimatedSprite2D.flip_h = not $AnimatedSprite2D.flip_h
		$floor_check.position.x = abs($CollisionShape2D.shape.get_size().x / 2) * direction

	if is_on_floor():
		velocity.y = 0
	else:
		velocity.y += 20  

	velocity.x = 50 * direction  
	$AnimatedSprite2D.play("movement")
	move_and_slide()


func _on_area_2d_body_entered(body: Node) -> void:
	# Check if the body is specifically the player (redman)
	if body.name == "redman" and body.velocity.y > 0:  # Ensure the player is falling
		squash_and_defeat()
		body.velocity.y = -200  # Make the player bounce upward

func squash_and_defeat() -> void:
	direction = 0  # Stop movement
	velocity = Vector2.ZERO
	$AnimatedSprite2D.play("defeated")  # Play squash animation
	await $AnimatedSprite2D.animation_finished  # Wait for the squash animation to finish
	queue_free()  # Delete the enemy
