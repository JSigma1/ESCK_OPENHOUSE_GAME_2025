extends Control

func _ready():
	$".".visible = false

func _on_key_task_1_fail():
	$".".visible = true	
	await get_tree().create_timer(0.5).timeout
	$".".visible = false	

func _when_correct():
	$".".visible = true	
	await get_tree().create_timer(1).timeout
	$".".visible = false	

func _on_key_task_4_success():
	_when_correct()


func _on_key_task_3_success():
	_when_correct()


func _on_key_task_2_success(door_id_string):
	_when_correct()


func _on_key_task_1_success(door_id_string):
	_when_correct()
