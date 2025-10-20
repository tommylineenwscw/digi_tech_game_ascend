extends CharacterBody2D

var CAN_DASH: float = true
const SPEED = 55.0
const JUMP_VELOCITY = -250.0
const DASH = 400
var can_move = true
signal dash_pressed
@onready var timer: Timer = $DashTimer
@onready var movable: Timer = $Movable

func _ready():
	$Movable.wait_time = 0.001
	movable.start()
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	elif CAN_DASH >= 0:
		CAN_DASH = 1
	
	if velocity.x == (0.0):
		$AnimatedSprite2D.play("idle")
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		print(velocity.y)
		
	if Input.is_action_just_pressed("dash"):
		emit_signal("dash_pressed")

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left move", "right move") 
	if direction:
		if direction == -1.0:
			$AnimatedSprite2D.flip_h = true
		
		if direction == 1.0:
			$AnimatedSprite2D.flip_h = false
	
	if Input.is_action_just_pressed("dash"):
		emit_signal("dash_pressed")
		
	move_and_slide()

func _on_dash_pressed() -> void:
	if CAN_DASH == 1:
		$Movable.wait_time = 0.25
		movable.start()
		CAN_DASH = -1
		timer.start()

		if $AnimatedSprite2D.flip_h == true:
			velocity.x = DASH * -1

		else:
			velocity.x = DASH

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()


func _on_dash_timer_timeout() -> void:
	if CAN_DASH <= 0:
		CAN_DASH += 0.05
		timer.start()

func _on_movable_timeout() -> void:
	var direction := Input.get_axis("left move", "right move")
	if direction:
		$AnimatedSprite2D.play("run")
		$Movable.wait_time = 0.001
		velocity.x = direction * SPEED

		if direction == -1.0:
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.offset = Vector2(2, 0)

		if direction == 1.0:
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.offset = Vector2(0, 0)

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.x -= velocity.x
		
	move_and_slide()

func _on_chicken_dash_refreshed() -> void:
	CAN_DASH = 1
