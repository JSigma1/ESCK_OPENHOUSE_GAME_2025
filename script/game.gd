extends Node2D

@onready var transition_camera: Camera2D = $Camera/TransitionCamera
@onready var camera_1: Camera2D = $Camera/Camera1
@onready var camera_2: Camera2D = $Camera/Camera2
@onready var camera_3: Camera2D = $Camera/Camera3
@onready var camera_4: Camera2D = $Camera/Camera4
@onready var camera_5: Camera2D = $Camera/Camera5
@onready var player_camera: Camera2D = $Environment/player/Camera2D

var power = 0
var start_time:float = 0.0
var end_time:float = 0.0
var is_timing:float = 0.0
var is_starting = false
var elapsed : float

signal call_congrats
signal elapesd_signal(time)

func _ready():
	$Animation_scene/start_menu.visible = true

func stop_watch():
	if is_timing:
		end_time = Time.get_ticks_msec() / 1000.0
		elapsed = end_time - start_time
		is_timing = false 
		elapesd_signal.emit(elapsed)

func transition_to(target:Camera2D,dur:float = 2.0)->void:
	var tw = create_tween()
	tw.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tw.tween_property(transition_camera, "global_transform", target.global_transform, dur)
	tw.set_parallel().tween_property(transition_camera, "zoom", target.zoom, dur)
	tw.set_parallel().tween_property(transition_camera, "offset", target.offset, dur)
	await tw.finished

func _on_key_task_2_success(door_id_string):
	power += 1
	print(power)


func _on_key_task_1_success(door_id_string):
	power += 1
	print(power)


func _on_key_task_3_success():
	power += 1
	print(power)


func _on_key_task_4_success():
	power += 1
	print(power)

func _process(delta):
	if power >= 4:
		stop_watch()
		$Animation_scene/Control.visible = true

func DialogicSignal(argument : String):
	if argument == "change_camera":
		transition_camera.make_current()
		await transition_to(camera_2,1.8)
		await transition_to(camera_3,1.8)
		await transition_to(camera_4,1.8)
		await transition_to(camera_5,1.8)
		await transition_to(player_camera,2.8)
		player_camera.make_current()

func _on_start_menu_starting():
	$Animation_scene/Control.visible = false
	$Environment/player.control_enable = false 
	$Animation_scene/start_menu.visible = false
	Dialogic.start("ask_name")
	Dialogic.signal_event.connect(DialogicSignal)
	await Dialogic.timeline_ended
	print(Dialogic.VAR.name)
	#start time
	start_time = Time.get_ticks_msec()/1000.0
	is_timing = true	

func _on_when_player_die_restart() -> void:
	get_tree().reload_current_scene()
