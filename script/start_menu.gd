extends Control

signal starting

func _on_button_pressed():
	emit_signal("starting")
