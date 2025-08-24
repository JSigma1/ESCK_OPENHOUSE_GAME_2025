extends Control

signal player_died
var player_health = 3

func minus_health():
	# Use a match statement for a cleaner and more readable solution.
	match player_health:
		3:
			$HBoxContainer/AnimatedSprite2D.play("default")
			$HBoxContainer/AnimatedSprite2D2.play("default")
			$HBoxContainer/AnimatedSprite2D3.play("default")
		2:
			$HBoxContainer/AnimatedSprite2D.play("default")
			$HBoxContainer/AnimatedSprite2D2.play("default")
			$HBoxContainer/AnimatedSprite2D3.play("no_health")
		1:
			$HBoxContainer/AnimatedSprite2D.play("default")
			$HBoxContainer/AnimatedSprite2D2.play("no_health")
			$HBoxContainer/AnimatedSprite2D3.play("no_health")
		_: # This is the equivalent of 'else' for any other value.
			$HBoxContainer/AnimatedSprite2D.play("no_health")
			$HBoxContainer/AnimatedSprite2D2.play("no_health")
			$HBoxContainer/AnimatedSprite2D3.play("no_health")
			emit_signal("player_died")

func _on_key_task_1_fail() -> void:
	player_health -= 1
	print(player_health)
	minus_health()

func _on_start_menu_starting() -> void:
	$".".visible = true


func _on_key_task_2_fail() -> void:
	player_health -= 1
	print(player_health)
	minus_health()


func _on_key_task_3_fail() -> void:
	player_health -= 1
	print(player_health)
	minus_health()


func _on_key_task_4_fail() -> void:
	player_health -= 1
	print(player_health)
	minus_health()
