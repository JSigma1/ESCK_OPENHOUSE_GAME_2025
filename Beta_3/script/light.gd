extends Node2D

# An enum creates a dropdown list in the Inspector for easy selection.
# Make sure the enum names (e.g., Front) match the animation names in your SpriteFrames.
enum Animations {
	Front,
	Side  # You can add as many as you need
}

# This exports the enum as a variable you can set in the editor.
@export var initial_animation: Animations = Animations.Front

@onready var animated_sprite = $AnimatedSprite2D


func _ready():
	# Convert the enum selection into its String name.
	# For example, `Animations.Front` becomes "Front".
	var animation_to_play = Animations.keys()[initial_animation]
	
	animated_sprite.play(animation_to_play)
