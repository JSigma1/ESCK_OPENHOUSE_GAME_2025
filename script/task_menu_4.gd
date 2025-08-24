extends Control

# Change the signal to send a String
signal success

# Add this variable to set in the Inspector

func complete():
	$AnimationPlayer.play_backwards("Blur")
	emit_signal("success")
	
func trigger():
		#get_tree().paused = true
		$AnimationPlayer.play("Blur")

func _on_button_pressed():
	complete()

func _on_cancel_pressed():
	#get_tree().paused = false
	$AnimationPlayer.play_backwards("Blur")

func _on_key_task_4_body_entered(body):
	if body.is_in_group("player"):
		trigger()
