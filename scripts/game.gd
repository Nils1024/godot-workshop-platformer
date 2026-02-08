extends Node

@onready var textbox = $Textbox

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$FadeTransition/AnimationPlayer.play("fade_out")
	textbox.offset = Vector2(400, 200)
	
	textbox.queue_text("Hello, welcome to Godot!")
	textbox.queue_text("In this small tutorial, you will build a 2D game with a player that can run and jump around.")
	textbox.queue_text("First of all I want to show you all the important areas of Godot.")
