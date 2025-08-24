extends CharacterBody2D

@export var door :Node = null
@export var max_speed: int  = 50
@export var accerelation : int = 5
@export var friction : int = 8
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var control_enable = true 
var last_dir = Vector2.DOWN

func _ready() -> void:
	add_to_group("player")
	$NavigationAgent2D.target_position = door.global_position
	
	

func _process(delta: float) -> void:
	var input = Vector2(Input.get_action_strength("right")-Input.get_action_strength("left"),
	Input.get_action_strength("down") - Input.get_action_strength("up")).normalized()
	
	if control_enable :
		if input :
			last_dir = input
			if input.x != 0 :
				animated_sprite_2d.play("walk")
				animated_sprite_2d.flip_h = true if input.x < 0 else false
			elif input.y < 0:
				animated_sprite_2d.play("w_walk")
			elif input.y > 0 :
				animated_sprite_2d.play("s_walk")
		else :
			if last_dir.x != 0 :
				animated_sprite_2d.play("idle")
			elif last_dir.y < 0:
				animated_sprite_2d.play("w_idle")
			elif last_dir.y > 0 : 
				animated_sprite_2d.play("s_idle")
		var lerp_weight = delta * (accerelation if input else friction)
		velocity = lerp(velocity,input * max_speed , lerp_weight)
		move_and_slide()
	else :
		if last_dir.x != 0 :
			animated_sprite_2d.play("idle")
		elif last_dir.y < 0:
			animated_sprite_2d.play("w_idle")
		elif last_dir.y > 0 : 
			animated_sprite_2d.play("s_idle")
		velocity = Vector2.ZERO
		move_and_slide()
		if !$NavigationAgent2D.is_target_reached() and Dialogic.current_timeline == null:
			animated_sprite_2d.play("s_walk")
			var nav_point_direction = to_local($NavigationAgent2D.get_next_path_position()).normalized()
			velocity = nav_point_direction * max_speed
			$Timer.start()
			move_and_slide()
		elif $NavigationAgent2D.is_target_reached():
			control_enable = true
			$"../../Animation_scene/Game_start/AnimationPlayer".play("fade")
			$"../../Animation_scene/Game_start/AnimationPlayer".speed_scale = 0.5
			
func _on_timer_timeout() -> void:
	if $NavigationAgent2D.target_position != door.global_position:
		$NavigationAgent2D.target_position = door.global_position
	$Timer.start()
