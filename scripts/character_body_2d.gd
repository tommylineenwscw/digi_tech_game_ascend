extends CharacterBody2D

var CAN_DASH: float = true
const SPEED = 100.0
const JUMP_VELOCITY = -300.0
const DASH = 1000
signal dash_pressed
@onready var timer: Timer = $DashTimer

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	elif CAN_DASH >= 0:
		CAN_DASH = 1

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left move", "right move")
	if direction:
		var move_velocity = direction * SPEED
		velocity.x += move_velocity
		
		if direction == -1.0:
			$AnimatedSprite2D.flip_h = true
		
		if direction == 1.0:
			$AnimatedSprite2D.flip_h = false
	else:
		var move_velocity 
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if Input.is_action_just_pressed("dash"):
		emit_signal("dash_pressed")
		
	move_and_slide()


func _on_dash_pressed() -> void:
	if CAN_DASH == 1:

		CAN_DASH = -1
		timer.start()
		
		if Input.is_action_just_pressed("left move"):
			var direction := Input.get_axis("left move", "right move")
			velocity.x += direction + DASH
			
		if Input.is_action_just_pressed("right move"):
			var direction := Input.get_axis("left move", "right move")
			velocity.x += direction + DASH
		
		elif $AnimatedSprite2D.flip_h == true:
			velocity.x -= DASH
		
		else:
			velocity.x += DASH
			
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)


func _on_dash_timer_timeout() -> void:
	if CAN_DASH <= 0:
		CAN_DASH += 0.05
		timer.start()








var direction := Input.get_axis("left move", "right move")
	if direction and can_move == true:
		$Movable.wait_time = 0.1
		velocity.x = direction * SPEED
		
		if direction == -1.0:
			$AnimatedSprite2D.flip_h = true
		
		if direction == 1.0:
			$AnimatedSprite2D.flip_h = false
	else:
		var move_velocity 
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if Input.is_action_just_pressed("dash"):
		emit_signal("dash_pressed")
		
	move_and_slide()
