extends CharacterBody2D

#States timers, varibles, constants and singal "Dash_pressed"
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

#In beginning of scene sets offset, wait time and starts movable timer
func _ready():
	$Movable.wait_time = 0.001
	$PlayerAnimations.offset = Vector2(0, 0)
	movable.start()
	
#Runs every tick
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and $Movable.wait_time == 0.001:
			velocity += get_gravity() * delta
	elif CAN_DASH >= 0:
		#If player is on ground and dash is almost ready it makes it fully ready to be used again
		CAN_DASH = 1
	
	if velocity.x == (0.0) and dead == 0 and $PlayerAnimations.animation not in ("dash"):
		if CAN_DASH >= 0:
			$PlayerAnimations.play("idle")
		else:
			$PlayerAnimations.play("no_dash_idle")
			
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	#Emit dash signal
	if Input.is_action_just_pressed("dash"):
		emit_signal("dash_pressed")

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left move", "right move") 
	if direction and dead == 0:
		#Flip character
		if direction == -1.0:
			$PlayerAnimations.flip_h = true

		if direction == 1.0:
			$PlayerAnimations.flip_h = false

	#Emit dash signal
	if Input.is_action_just_pressed("dash"):
		emit_signal("dash_pressed")
		
	move_and_slide()

#Handle dash
func _on_dash_pressed() -> void:
	if CAN_DASH == 1 and dead == 0:
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

#Start refresh dash
func _on_dash_timer_timeout() -> void:
	if CAN_DASH <= 0:
		CAN_DASH += 0.05
		timer.start()

#Handle movement
func _on_movable_timeout() -> void:
	if $PlayerAnimations.animation in ("dash") and dead == 0:
		$PlayerAnimations.play("no_dash_idle")

	$Movable.wait_time = 0.001
	var direction := Input.get_axis("left move", "right move")
	if direction and dead == 0:
		if CAN_DASH >= 0:
			$PlayerAnimations.play("run")
		else:
			$PlayerAnimations.play("no_dash_run")
		velocity.x = direction * SPEED

		if direction == -1.0:
			#Filp charatcer
			$PlayerAnimations.flip_h = true
			$PlayerAnimations.offset = Vector2(2, 0)

		if direction == 1.0:
			$PlayerAnimations.flip_h = false
			$PlayerAnimations.offset = Vector2(0, 0)

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.x -= velocity.x
		
	move_and_slide()

#Handle chicken
func _on_chicken_dash_refreshed() -> void:
	CAN_DASH = 1

#Handle spikes signal
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

#Handle death
func _on_death_time_timeout() -> void:
	get_tree().reload_current_scene()
