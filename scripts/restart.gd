extends Button

#Restarts game when pressed
func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/startMenu.tscn")
	Engine.time_scale = 1
