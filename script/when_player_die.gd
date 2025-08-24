extends Control

signal restart

func _ready():
	$".".visible = false

func _on_player_health_player_died() -> void:
		$".".visible = true	


func _on_button_pressed() -> void:
	emit_signal("restart")
