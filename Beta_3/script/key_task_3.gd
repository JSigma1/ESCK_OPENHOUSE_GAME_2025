extends Area2D

signal success

func _on_question_success():
	emit_signal("success")
	print("task 3 complete")
	$"../../Environment/player".control_enable = true
	queue_free()
