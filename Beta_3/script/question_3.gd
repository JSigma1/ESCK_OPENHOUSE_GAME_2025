extends Control

# Change the signal to send a String
signal success


# Add this variable to set in the Inspector

func _ready():
	$".".visible = false

func complete():
	$".".visible = false
	emit_signal("success")
	
func trigger():
	$".".visible = true

func _on_button_pressed():
	$".".visible = false


func _on_button_2_pressed():
	$".".visible = false


func _on_button_3_pressed():
	$".".visible = false


func _on_button_4_pressed():
	complete()


func _on_key_task_3_body_entered(body):
	if body.is_in_group("player"):
		await get_tree().create_timer(0.5).timeout
		trigger()
