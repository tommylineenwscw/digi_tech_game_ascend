extends Area2D

#States timer
@onready var timer: Timer = $Timer

#Detects if player entered killzone and starts timer
func _on_body_entered(body: CharacterBody2D) -> void:
	print ("You died!")
	timer.start()

#Restarts level after time
func _on_timer_timeout(): 
	Engine.time_scale = 1
	get_tree().reload_current_scene()
