extends Area2D

signal success

func _on_question_success():
	emit_signal("success")
	print("task 4 complete")
	$"../../Environment/player".control_enable = true
	queue_free()
	
