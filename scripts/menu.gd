extends MarginContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		if $".".visible == false:
			$".".visible = true
			Engine.time_scale = 0
		else:
			$".".visible = false
			Engine.time_scale = 1
