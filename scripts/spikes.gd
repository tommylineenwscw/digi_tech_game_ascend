extends Area2D
signal spikes

func _on_body_entered(body: CharacterBody2D) -> void:
	print("Detected")
	Engine.time_scale = 0.3
	$"../TileMapLayer".collision_enabled = false
	emit_signal("spikes")
	
