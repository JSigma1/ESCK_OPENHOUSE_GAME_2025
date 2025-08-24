extends CharacterBody2D

@export var quest1:Node= null

var speed : float =50.0
var did_not_play_dialog = true
var can_move = false 
func _ready() -> void:
	add_to_group("robot")
	$AnimatedSprite2D.play("default")
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and did_not_play_dialog:
		$"../player".control_enable = false 
		if Dialogic.current_timeline != null :
			await Dialogic.timeline_ended
		Dialogic.start("talk_to_robot")
		await Dialogic.timeline_ended 
		did_not_play_dialog = false 
		await get_tree().create_timer(2).timeout
		queue_free()
