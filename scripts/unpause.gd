extends Button
@onready var timer: Timer = $Timer

#Unpauses game on press
func _on_pressed() -> void:
	timer.start()
	$"../..".visible = false
	Engine.time_scale = 1
