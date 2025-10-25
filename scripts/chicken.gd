extends Area2D

#States timers and signal
@onready var Eaten: Timer = $Eaten
@onready var edible = true
signal dash_refreshed

#Plays eat animation, makes inedible, emits dash refreshed
func _on_body_entered(body: CharacterBody2D) -> void:
	if edible == true:
		$AnimatedSprite2D.play("eat")
		print ("You ate chicken")
		edible = false
		Eaten.start()
		emit_signal("dash_refreshed")

#Retores chicken after timer
func _on_eaten_timeout() -> void:
	$AnimatedSprite2D.play("reset")
	edible = true
