extends Node2D

var show_robot_1 = false
var show_robot_2 = false
var show_robot_3 = false 
var show_robot_4 = false 

var robot_1_alive = true
var robot_2_alive = true
var robot_3_alive = true 
var robot_4_alive = true 

func _ready() -> void:
	$robot_quest1.visible = false
	$robot_quest1/CollisionShape2D.disabled = true
	$robot_quest2.visible = false
	$robot_quest2/CollisionShape2D.disabled = true
	$robot_quest3.visible = false
	$robot_quest3/CollisionShape2D.disabled = true
	$robot_quest4.visible = false
	$robot_quest4/CollisionShape2D.disabled = true

func _on_spawn_1_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not show_robot_1:
		$smoke_1.play("default")
		await $smoke_1.animation_finished
		show_robot_1 = false
		$robot_quest1.visible = true
		$robot_quest1/CollisionShape2D.disabled = false
		$remain_time_robot_1.start()

func _on_spawn_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not show_robot_2:
		$smoke_2.play("default")
		await $smoke_2.animation_finished
		show_robot_2 = false
		$robot_quest2.visible = true
		$robot_quest2/CollisionShape2D.disabled = false
		$remain_time_robot_2.start()

func _on_spawn_3_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not show_robot_3:
		$smoke_3.play("default")
		await $smoke_3.animation_finished
		show_robot_3 = false
		$robot_quest3.visible = true
		$robot_quest3/CollisionShape2D.disabled = false
		$remain_time_robot_3.start()
		
func _on_spawn_4_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not show_robot_4:
		$smoke_4.play("default")
		await $smoke_4.animation_finished
		show_robot_4 = false
		$robot_quest4.visible = true
		$robot_quest4/CollisionShape2D.disabled = false
		$remain_time_robot_4.start()
		

func _on_remain_time_robot_1_timeout() -> void:
	if robot_1_alive:
		$robot_quest1.queue_free()
		show_robot_1 = true
		robot_1_alive = false 

func _on_remain_time_robot_2_timeout() -> void:
	if robot_2_alive:
		$robot_quest2.queue_free()
		show_robot_2 = true
		robot_2_alive = false

func _on_remain_time_robot_3_timeout() -> void:
	if robot_3_alive:
		$robot_quest3.queue_free()
		show_robot_3 = true
		robot_3_alive = false

func _on_remain_time_robot_4_timeout() -> void:
	if robot_4_alive:
		$robot_quest3.queue_free()
		show_robot_4 = true
		robot_4_alive = false
	
