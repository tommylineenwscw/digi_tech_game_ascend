extends CharacterBody2D

var CAN_DASH: float = true
const SPEED = 100.0
const JUMP_VELOCITY = -300.0
const DASH = 100
signal dash_pressed
@onready var timer: Timer = $DashTimer
@onready var move_timer: Timer = $Move_timer


func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	elif CAN_DASH >= 0:
		CAN_DASH = 1

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("left move", "right move") 
	if direction:
		velocity.x += direction * SPEED
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.x -= direction * SPEED
		print("added movement")
		if direction == -1.0:
			$AnimatedSprite2D.flip_h = true
		
		if direction == 1.0:
			$AnimatedSprite2D.flip_h = false
	else:
		velocity.x -= direction * SPEED
	
	if Input.is_action_just_pressed("dash"):
		emit_signal("dash_pressed")
		move_timer.start()
		
	move_and_slide()


func _on_dash_pressed() -> void:
	print("umm")
	if CAN_DASH == 1:
		print("Dashed")
		CAN_DASH = -1
		timer.start()
			
			
		
		if $AnimatedSprite2D.flip_h == true:
			if Input.is_action_pressed("jump"):
				velocity.x -= DASH
				velocity.y += 500
			else: 
				velocity.x -= DASH
			
		
		else:
			if Input.is_action_pressed("jump"):
				velocity.x += DASH
				velocity.y += 500
			else:
				velocity.x += DASH
			
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)


func _on_dash_timer_timeout() -> void:
	if CAN_DASH <= 0:
		CAN_DASH += 0.05
		print(CAN_DASH)
		timer.start()
		
