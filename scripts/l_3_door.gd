extends Area2D

func _ready() -> void:
	$"../Player/Camera2D/CanvasLayer/Control".visible = false
	$CollisionShape2D.disabled = false

#When entered goes two level 2
func _on_body_entered(body: CharacterBody2D) -> void:
	$CollisionShape2D.disabled = true
	$"../Player/Camera2D/CanvasLayer/Control".visible = true
	$"../Player/Camera2D/CanvasLayer/Control/TextureRect/AnimatedSprite2D".frame = 0
	$"../Player/Camera2D/CanvasLayer/Control/TextureRect/AnimatedSprite2D".play("new_animation_1")
