extends Control

# Change the signal to send a String
signal success
signal fail

# Add this variable to set in the Inspector

func _ready():
	$".".visible = false

func complete():
	$".".visible = false
	emit_signal("success")
	
func trigger():
	$".".visible = !$".".visible

func _on_button_pressed():
	emit_signal("fail")


func _on_button_2_pressed():
	complete()


func _on_button_3_pressed():
	emit_signal("fail")


func _on_button_4_pressed():
	emit_signal("fail")


func _on_key_task_4_body_entered(body):
	if body.is_in_group("player"):
		
		trigger()
		

func _on_key_task_4_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		
		trigger()
