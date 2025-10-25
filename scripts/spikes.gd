extends Area2D
signal spikes

#Turns off map collisons, slows down game and emits signal "spike" when player enters it
func _on_body_entered(body: CharacterBody2D) -> void:
	Engine.time_scale = 0.3
	$"../TileMapLayer".collision_enabled = false
	emit_signal("spikes")
	
