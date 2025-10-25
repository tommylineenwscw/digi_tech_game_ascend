extends Area2D

#When entered goes two level 2
func _on_body_entered(body: CharacterBody2D) -> void:
	get_tree().change_scene_to_file("res://scenes/level_2.tscn")
