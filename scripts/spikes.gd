extends Area2D

func _on_body_entered(body: CollisionShape2D) -> void:
	print("Detected")
	Engine.time_scale = 0.75
	body.get_node("SpikesHitBox").queue_free()
