extends Control

func _ready():
	$".".visible = false
	
func _when_incorrect():
	$".".visible = true	
	await get_tree().create_timer(0.5).timeout
	$".".visible = false	

func _on_key_task_1_fail():
	_when_incorrect()


func _on_key_task_2_fail():
	_when_incorrect()


func _on_key_task_3_fail():
	_when_incorrect()


func _on_key_task_4_fail():
	_when_incorrect()
