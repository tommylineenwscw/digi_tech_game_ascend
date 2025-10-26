extends Area2D

#States timers
@onready var Destroy: Timer = $"../Break"
@onready var Repair: Timer = $"../Return"

#Runs when player steps on platform
func _on_body_entered(body: CharacterBody2D) -> void:
	print ("You stood on breakble platform")
	$"../AnimatedSprite2D".play("go")
	Destroy.start()
	
#Turns off the platform when destroy timer goes off
func _on_break_timeout() -> void:
	print ("break")
	$"../Stand".disabled = true
	$"../AnimatedSprite2D".visible = false
	Repair.start()

#Returns platform after repaid timeout
func _on_return_timeout() -> void:
	print ("return")
	$"../AnimatedSprite2D".play("come_back")
	$"../Stand".disabled = false
	$"../AnimatedSprite2D".visible = true
