extends Control

signal call_leaderboard

#func _ready():
	#get_node("summit").visible = false

func _on_button_pressed():
	emit_signal("call_leaderboard")
	#$"../summit".visible = true
	
