extends Node

@onready var textbox = $Textbox

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	textbox.set_text("Hello, welcome to Godot!")
