extends Node

@onready var textbox = $Textbox

enum GameState {
	INTRO,
	NODE_INTRO,
	FILE_INTRO,
	INSPECTOR_INTRO,
	WORKSPACE_INTRO,
	CREATE_ROOT_NODE_1,
	CREATE_ROOT_NODE_2,
	CREATE_ROOT_NODE_3,
	CREATE_ROOT_NODE_FINISHED,
	SAVE_1,
	SAVE_FINISHED,
}	

var current_game_state = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$FadeTransition/AnimationPlayer.play("fade_out")
	textbox.offset = Vector2(400, 200)
	
	await Util.wait(1)
	
	textbox.queue_text("Hello, welcome to Godot!")
	textbox.queue_text("In this small tutorial, you will build a 2D game with a player that can run and jump around.")
	textbox.queue_text("First of all I want to show you all the important areas of Godot.")
	
	current_game_state = GameState.INTRO
	
func _process(delta: float) -> void:
	if textbox.text_queue.is_empty() and textbox.current_state == textbox.State.READY:
		match current_game_state:
			GameState.INTRO:
				$Panel.show()
				textbox.queue_text("Nodes and scenes are game parts. They will be listed here.")
				current_game_state = GameState.NODE_INTRO
			GameState.NODE_INTRO:
				$Panel.hide()
				$Panel2.show()
				textbox.queue_text("This is your file explorer. Here you will find all your files and folders (e.g. images, scenes and code).")
				current_game_state = GameState.FILE_INTRO
			GameState.FILE_INTRO:
				$Panel2.hide()
				$Panel3.show()
				textbox.queue_text("This is your inspector. When you selected a node, you can edit all its properties in here.")
				current_game_state = GameState.INSPECTOR_INTRO
			GameState.INSPECTOR_INTRO:
				$Panel3.hide()
				$Panel4.show()
				textbox.queue_text("This is your Main viewport. Here you can see what your game looks like.")
				current_game_state = GameState.WORKSPACE_INTRO
			GameState.WORKSPACE_INTRO:
				$Panel4.hide()
				textbox.queue_text("Now you know what you probably need the most. Let's start creating your first game!")
				current_game_state = GameState.CREATE_ROOT_NODE_1
			GameState.CREATE_ROOT_NODE_1:
				textbox.queue_text("In the Scene section, choose Other Node and select Node.")
				current_game_state = GameState.CREATE_ROOT_NODE_2
			GameState.CREATE_ROOT_NODE_3:
				$TextureRect2.show()
				$CreateButton.show()
			GameState.CREATE_ROOT_NODE_FINISHED:
				$TextureRect2.hide()
				$CreateButton.hide()
				$"2DSceneButton".hide()
				$"3DSceneButton".hide()
				$UserInterfaceButton.hide()
				$OtherNodeButton.hide()
				$TextureRect.hide()
				$TextureRect3.show()
				$NodeButton.show()
				
	# All other process logic
	if Input.is_action_just_pressed("left_click") and $RightClickMenu.visible and !$RightClickMenu.get_rect().has_point(get_viewport().get_mouse_position()):
			$RightClickMenu.hide()
			

func _on_other_node_button_pressed() -> void:
	current_game_state = GameState.CREATE_ROOT_NODE_3
	
func _on_user_interface_button_pressed() -> void:
	pass # Replace with function body.

func _on_3d_scene_button_pressed() -> void:
	pass # Replace with function body.

func _on_2d_scene_button_pressed() -> void:
	pass # Replace with function body.
	
func _on_create_button_pressed() -> void:
	current_game_state = GameState.CREATE_ROOT_NODE_FINISHED

func _on_node_button_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_RIGHT and event.pressed:
			$RightClickMenu.show()
			$RightClickMenu.global_position = get_viewport().get_mouse_position()
