extends CharacterBody2D

var CAN_DASH: float = true
const SPEED = 55.0
const JUMP_VELOCITY = -250.0
const DASH = 400
var can_move = true
signal dash_pressed
@onready var timer: Timer = $DashTimer
@onready var movable: Timer = $Movable
@onready var dietime: Timer = $DeathTime
@onready var dead = 0

func _ready():
	$Movable.wait_time = 0.001
	$PlayerAnimations.offset = Vector2(0, 0)
	movable.start()
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and $Movable.wait_time == 0.001:
			velocity += get_gravity() * delta
	elif CAN_DASH >= 0:
		CAN_DASH = 1
	
	if velocity.x == (0.0) and dead == 0 and $Movable.wait_time == 0.001:
		if CAN_DASH >= 0:
			$PlayerAnimations.play("idle")
		else:
			$PlayerAnimations.play("no_dash_idle")
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed("dash"):
		emit_signal("dash_pressed")

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left move", "right move") 
	if direction and dead == 0:
		if direction == -1.0:
			$PlayerAnimations.flip_h = true
		
		if direction == 1.0:
			$PlayerAnimations.flip_h = false
	
	if Input.is_action_just_pressed("dash"):
		emit_signal("dash_pressed")
		
	move_and_slide()

func _on_dash_pressed() -> void:
	if CAN_DASH == 1:
		$PlayerAnimations.play("dash")
		$Movable.wait_time = 0.25
		movable.start()
		CAN_DASH = -1
		timer.start()

		if $PlayerAnimations.flip_h == true:
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
	$Movable.wait_time = 0.001
	var direction := Input.get_axis("left move", "right move")
	if direction and dead == 0:
		if CAN_DASH >= 0:
			$PlayerAnimations.play("run")
		else:
			$PlayerAnimations.play("no_dash_run")
		velocity.x = direction * SPEED

		if direction == -1.0:
			$PlayerAnimations.flip_h = true
			$PlayerAnimations.offset = Vector2(2, 0)

		if direction == 1.0:
			$PlayerAnimations.flip_h = false
			$PlayerAnimations.offset = Vector2(0, 0)

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.x -= velocity.x
		
	move_and_slide()

func _on_chicken_dash_refreshed() -> void:
	CAN_DASH = 1


func _on_spikes_spikes() -> void:
	if dead == 0:
		velocity.y = JUMP_VELOCITY
		dead = 1
		dietime.start()
		if CAN_DASH >= 0:
			$PlayerAnimations.play("death")
		else:
			$PlayerAnimations.play("no_dash_death")
			if $PlayerAnimations.flip_h == true:
				$PlayerAnimations.offset = Vector2(13, 9)
			else:
				$PlayerAnimations.offset = Vector2(-8, 9)

func _on_death_time_timeout() -> void:
	get_tree().reload_current_scene()
