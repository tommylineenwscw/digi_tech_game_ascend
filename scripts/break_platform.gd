extends Area2D

@onready var Destroy: Timer = $"../Break"
@onready var Repair: Timer = $"../Return"

func _on_body_entered(body: CharacterBody2D) -> void:
	print ("You stood on breakble platform")
	Destroy.start()
	
func _on_return_timeout() -> void:
	print ("return")
	$"../Stand".disabled = false
	$"../Sprite2D".visible = true

func _on_break_timeout() -> void:
	print ("break")
	$"../Stand".disabled = true
	$"../Sprite2D".visible = false
	Repair.start()
