extends MarginContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		#Turns on menu if it is off and escape is pressed
		if $".".visible == false:
			$".".visible = true
			Engine.time_scale = 0
		
		#Exits menu if it is already on and escape is pressed
		else:
			$".".visible = false
			Engine.time_scale = 1
