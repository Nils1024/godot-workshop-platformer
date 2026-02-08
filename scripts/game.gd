extends Node

@onready var textbox = $Textbox

enum GameState {
	INTRO,
	NODE_INTRO,
	FILE_INTRO,
	INSPECTOR_INTRO,
	WORKSPACE_INTRO
}

var current_game_state = GameState.INTRO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$FadeTransition/AnimationPlayer.play("fade_out")
	textbox.offset = Vector2(400, 200)
	
	textbox.queue_text("Hello, welcome to Godot!")
	textbox.queue_text("In this small tutorial, you will build a 2D game with a player that can run and jump around.")
	textbox.queue_text("First of all I want to show you all the important areas of Godot.")
	
func _process(delta: float) -> void:
	if textbox.text_queue.is_empty() and textbox.current_state == textbox.State.READY:
		match current_game_state:
			GameState.INTRO:
				$Panel.show()
				textbox.queue_text("This is your node editor")
				current_game_state = GameState.NODE_INTRO
			GameState.NODE_INTRO:
				$Panel.hide()
				$Panel2.show()
				textbox.queue_text("This is your file explorer")
				current_game_state = GameState.FILE_INTRO
			GameState.FILE_INTRO:
				$Panel2.hide()
				$Panel3.show()
				textbox.queue_text("This is your inspector")
				current_game_state = GameState.INSPECTOR_INTRO
			GameState.INSPECTOR_INTRO:
				$Panel3.hide()
				$Panel4.show()
				textbox.queue_text("This is your workspace")
				current_game_state = GameState.WORKSPACE_INTRO
