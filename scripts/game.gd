extends Node

@onready var textbox = $Textbox

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$FadeTransition/AnimationPlayer.play("fade_out")
	textbox.offset = Vector2(200, 200)
	
	textbox.queue_text("Hello, welcome to Godot!")
	textbox.queue_text("we are going")
	textbox.queue_text("123456778")
	textbox.queue_text("abcdefghh")
