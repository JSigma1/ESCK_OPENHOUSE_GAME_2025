extends StaticBody2D

var player_is_nearby = false

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready():
	animation.play("close")
	
func _process(_delta):
	if player_is_nearby:
	
		collision_shape.set_deferred("disabled", true)
		animation.play("open")
	else:
	
		collision_shape.set_deferred("disabled", false)
		animation.play("close")

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player_is_nearby = true

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		player_is_nearby = false
