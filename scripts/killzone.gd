extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: CharacterBody2D) -> void:
	print ("You died!")
	timer.start()


func _on_timer_timeout(): 
	Engine.time_scale = 1
	get_tree().reload_current_scene()
