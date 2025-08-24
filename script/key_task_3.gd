extends Area2D

signal success
signal fail

func _on_question_success():
	emit_signal("success")
	print("task 3 complete")
	queue_free()


func _on_question_fail():
	emit_signal("fail")
