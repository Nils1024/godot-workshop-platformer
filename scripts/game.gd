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
	SAVE_2,
	SAVE_3,
	SAVE_FINISHED,
	ADD_PLAYER_1,
	ADD_PLAYER_2,
	ADD_PLAYER_3,
	ADD_PLAYER_4,
	ADD_PLAYER_5,
	ADD_PLAYER_6,
	ADD_PLAYER_7,
	ADD_PlAYER_8,
	ADD_PLAYER_SCRIPT_1,
	ADD_PLAYER_SCRIPT_2,
	ADD_PLAYER_SCRIPT_3,
	ADD_PLAYER_SCRIPT_4,
	ADD_PLAYER_SCRIPT_5,
}	

var current_game_state = null
var is_dragging := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$FadeTransition/AnimationPlayer.play("fade_out")
	textbox.offset = Vector2(400, 200)
	
	await Util.wait(1)
	
	textbox.queue_text("Hello, welcome to Godot!")
	textbox.queue_text("In this small tutorial, you will build a 2D game with a player that can run and jump around.")
	textbox.queue_text("First of all I want to show you all the important areas of Godot.")
	
	current_game_state = GameState.INTRO
	
func _process(_delta: float) -> void:
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
				current_game_state = GameState.SAVE_1
			GameState.SAVE_1:
				textbox.queue_text("Now that we created our first changes to our game we should save it. Press CTRL + S for it")
				current_game_state = GameState.SAVE_2
			GameState.SAVE_2:
				if Input.is_action_just_pressed("save"):
					$TextureRect4.show()
					$SaveTextField.show()
					$SaveButton.show()
					textbox.queue_text("Good! Now name it \"main.tscn\"")
					current_game_state = GameState.SAVE_3
			GameState.SAVE_FINISHED:
				$SaveButton.hide()
				$SaveTextField.hide()
				$TextureRect5.show()
				current_game_state = GameState.ADD_PLAYER_1
			GameState.ADD_PLAYER_1:
				textbox.queue_text("Right click on your node and click add a child node or just press CTRL + A")
				current_game_state = GameState.ADD_PLAYER_2
			GameState.ADD_PLAYER_2:
				if Input.is_action_just_pressed("left_click") and $RightClickMenu.visible and !$RightClickMenu.get_rect().has_point(get_viewport().get_mouse_position()):
					$RightClickMenu.hide()
				elif Input.is_action_just_pressed("new_node"):
					$TextureRect6.show()
					$CharacterBody2DButton.show()
					$CharacterBody2DCreateButton.show()
					current_game_state = GameState.ADD_PLAYER_3
			GameState.ADD_PLAYER_4:
				$NodeButton.hide()
				textbox.queue_text("Now add a Sprite2D node to the CharacterBody2D")
				$CharacterBody2DSideButton.show()
				current_game_state = GameState.ADD_PLAYER_5
			GameState.ADD_PLAYER_5:
				if Input.is_action_just_pressed("left_click") and $RightClickMenu.visible and !$RightClickMenu.get_rect().has_point(get_viewport().get_mouse_position()):
					$RightClickMenu.hide()
				elif Input.is_action_just_pressed("new_node"):
					$RightClickMenu.hide()
					$TextureRect9.show()
					$Sprite2DButton.show()
					$Sprite2DCreateButton.show()
			GameState.ADD_PLAYER_6:
				textbox.queue_text("Now we want to add a character image. For that move the icon.svg from your file explorer to the texture field in your inspector.")
				$IconSVGButton.show()
				current_game_state = GameState.ADD_PLAYER_7
			GameState.ADD_PlAYER_8:
				textbox.queue_text("Right click on the CharacterBody2D and attach a script")
				$RightClickMenu/AttachScriptButton.show()
				$RightClickMenu/AddChildNodeButton.hide()
				current_game_state = GameState.ADD_PLAYER_SCRIPT_1
			GameState.ADD_PLAYER_SCRIPT_1:
				if Input.is_action_just_pressed("left_click") and $RightClickMenu.visible and !$RightClickMenu.get_rect().has_point(get_viewport().get_mouse_position()):
					$RightClickMenu.hide()
			GameState.ADD_PLAYER_SCRIPT_2:
				textbox.offset = textbox.offset + Vector2(400, 0)
				textbox.queue_text("As you can see here you can program your player with GDScript (Which is similar to Python)")
				textbox.queue_text("For simplicity I change the template script a bit for you so you can directly see some results")
				textbox.queue_text("When you are ready press the play button in the upper right corner and see what you have created")
				current_game_state = GameState.ADD_PLAYER_SCRIPT_3
			GameState.ADD_PLAYER_SCRIPT_3:
				$TextureRect15.show()
				$PlayButton.show()
			GameState.ADD_PLAYER_SCRIPT_4:
				textbox.offset = textbox.offset - Vector2(400, 0)
				textbox.queue_text("Here is the debug window, where you can test your game.")
				textbox.queue_text("With our player we created we can move around using W, A, S, D")
				textbox.queue_text("When you finished testing your game, press esc to end the tutorial")
				current_game_state = GameState.ADD_PLAYER_SCRIPT_5
			GameState.ADD_PLAYER_SCRIPT_5:
				if Input.is_action_just_pressed("esc"):
					textbox.queue_text("I hope you had fun following this tutorial and that you learnt something.")
					textbox.queue_text("Now its your turn! Hop in Godot and create something magical :)")
					get_tree().change_scene_to_file("res://scenes/main.tscn")

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
	if event is InputEventMouseButton and current_game_state == GameState.ADD_PLAYER_2:
		if event.button_index == MouseButton.MOUSE_BUTTON_RIGHT and event.pressed:
			$RightClickMenu.show()
			$RightClickMenu.global_position = get_viewport().get_mouse_position()

func _on_save_button_pressed() -> void:
	if $SaveTextField.text == "main.tscn":
		current_game_state = GameState.SAVE_FINISHED
	else:
		textbox.queue_text("Please name it \"main.tscn\"")

func _on_add_child_node_button_pressed() -> void:
	if current_game_state == GameState.ADD_PLAYER_2:
		$RightClickMenu.hide()
		$TextureRect6.show()
		$CharacterBody2DButton.show()
		$CharacterBody2DCreateButton.show()
		current_game_state = GameState.ADD_PLAYER_3
	elif current_game_state == GameState.ADD_PLAYER_5:
		$RightClickMenu.hide()
		$TextureRect9.show()
		$Sprite2DButton.show()
		$Sprite2DCreateButton.show()
	
func _on_character_body_2d_button_pressed() -> void:
	$TextureRect6.hide()
	$TextureRect7.show()
	
func _on_character_body_2d_create_button_pressed() -> void:
	if $TextureRect7.visible:
		$TextureRect7.hide()
		$CharacterBody2DCreateButton.hide()
		$CharacterBody2DButton.hide()
		$TextureRect8.show()
		current_game_state = GameState.ADD_PLAYER_4
		
func _on_character_body_2d_side_button_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_RIGHT and event.pressed:
			$RightClickMenu.show()
			$RightClickMenu.global_position = get_viewport().get_mouse_position()

func _on_sprite_2d_button_pressed() -> void:
	$TextureRect9.hide()
	$TextureRect10.show()

func _on_sprite_2d_create_button_pressed() -> void:
	if $TextureRect10.visible:
		$TextureRect10.hide()
		$Sprite2DButton.hide()
		$Sprite2DCreateButton.hide()
		$TextureRect11.show()
		current_game_state = GameState.ADD_PLAYER_6
		
func _on_icon_svg_button_gui_input(event: InputEvent) -> void:
	if current_game_state == GameState.ADD_PLAYER_7:
		if event is InputEventMouseButton:
			if event.button_index == MouseButton.MOUSE_BUTTON_LEFT and event.pressed:
				is_dragging = true
				$IconSVGDragIcon.show()
				$IconSVGDragIcon.global_position = get_viewport().get_mouse_position()
	
func _input(event: InputEvent) -> void:
	if not is_dragging:
		return

	var mouse_pos = get_viewport().get_mouse_position()

	if event is InputEventMouseMotion:
		$IconSVGDragIcon.global_position = mouse_pos + Vector2(20, 20)
		
		if $IconSVGButtonDest.get_global_rect().has_point(mouse_pos):
			$IconSVGButtonDest.show()
		else:
			$IconSVGButtonDest.hide()

	elif event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_LEFT and not event.pressed:
			is_dragging = false
			$IconSVGDragIcon.hide()
			
			if $IconSVGButtonDest.get_global_rect().has_point(mouse_pos):
				$IconSVGButton.hide() 
				$TextureRect12.show()
				$IconSVGButtonDest.hide()
				current_game_state = GameState.ADD_PlAYER_8

func _on_attach_script_button_pressed() -> void:
	$RightClickMenu.hide()
	$TextureRect13.show()
	$CreateScriptButton.show()

func _on_create_script_button_pressed() -> void:
	$TextureRect13.hide()
	$CreateScriptButton.hide()
	$TextureRect14.show()
	current_game_state = GameState.ADD_PLAYER_SCRIPT_2

func _on_play_button_pressed() -> void:
	$"Debug Screen".show()
	$CharacterBody2D.show()
	current_game_state = GameState.ADD_PLAYER_SCRIPT_4
