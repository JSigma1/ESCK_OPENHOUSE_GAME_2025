extends Area2D

signal success(door_id_string)

@export var target_door_id: String = ""

func _on_question_success():
	if not target_door_id.is_empty():
		# We emit the correct string ID that the door is listening for.
		success.emit(target_door_id) 	
		print("task 1 complete")
		$"../../Environment/player".control_enable = true
		queue_free()
	else:
		print("Warning: Target Door ID is not set in the Inspector!")
