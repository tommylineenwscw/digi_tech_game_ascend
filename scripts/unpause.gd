extends Button
@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_pressed() -> void:
	$AnimatedSprite2D.play("default")
	timer.start()

func _on_timer_timeout() -> void:
	print("working")
	$"../..".visible = false
