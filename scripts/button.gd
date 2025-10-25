extends Button
@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#Plays button animation then starts start timer
func _on_pressed() -> void:
	$AnimatedSprite2D.play("default")
	timer.start()

#Enters Level 0 after timeout
func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/level_0.tscn")
