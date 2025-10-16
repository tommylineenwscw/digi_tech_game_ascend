extends Area2D

@onready var Eaten: Timer = $Eaten
@onready var edible = true

func _on_body_entered(body: CharacterBody2D) -> void:
	if edible == true:
		print ("You ate chicken")
		var edible = false
		Player.CAN_DASH = 1

func _on_break_timeout() -> void:
	print ("break")
	var edible = true
