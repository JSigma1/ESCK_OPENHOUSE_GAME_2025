extends StaticBody2D

var player_is_nearby = false
var is_permanently_open = false
var is_complete = false

@export var door_id: String = ""

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready():
	animation.play("close")
	
func _process(_delta):
	if player_is_nearby and not is_permanently_open and is_complete:
		collision_shape.set_deferred("disabled", true)
		animation.play("open")
		is_permanently_open = true	

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player_is_nearby = true

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		player_is_nearby = false


func _on_key_task_1_success(id_from_signal: String):
	if id_from_signal == door_id:
		print("door 1 complete")
		is_complete = true


func _on_key_task_2_success(id_from_signal: String):
	if id_from_signal == door_id:
		print("door 2 complete")
		is_complete = true
