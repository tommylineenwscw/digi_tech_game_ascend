extends Label

@onready var timer: Timer = $"../Timer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".text = "0,00,00"
	timer.start()

func _on_timer_timeout() -> void:
	$".".text = "1"
