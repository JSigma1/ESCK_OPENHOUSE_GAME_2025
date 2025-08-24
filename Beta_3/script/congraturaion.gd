extends Control

signal call_leaderboard

func _ready():
	$"../summit".visible = false

func _on_button_pressed():
	emit_signal("call_leaderboard")
	$"../summit".visible = true
	
