extends CanvasLayer

@onready var textbox_container = $TextboxContainer
@onready var textfield = $TextboxContainer/MarginContainer/VBoxContainer/HBoxContainer/Text
@onready var continue_button = $TextboxContainer/MarginContainer/VBoxContainer/HBoxContainer2/TextureButton

enum State {
	READY,
	READING,
	FINISHED
}

var current_state = State.READY
var text_queue = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	continue_button.pressed.connect(_on_continue_pressed)
	
	hide_textbox()
	
func _process(detla) -> void:
	match current_state:
		State.READY:
			if !text_queue.is_empty():
				display_text()
		State.READING:
			#TODO: Skip text animation
			pass
	
func _on_continue_pressed():
	match current_state:
		State.FINISHED:
			change_state(State.READY)
			hide_textbox()
	
func queue_text(text):
	text_queue.push_back(text)
	
func display_text():
	textfield.text = text_queue.pop_front()
	textfield.visible_characters = 0
	change_state(State.READING)
	show_textbox()

	var tween = create_tween()
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.finished.connect(_on_tween_finished, CONNECT_ONE_SHOT)
	tween.tween_property(textfield, "visible_characters", len(textfield.text), 1.2)
	
func _on_tween_finished():
	continue_button.disabled = false
	change_state(State.FINISHED)
	
func hide_textbox():
	textbox_container.hide()
	
func show_textbox():
	textbox_container.show()
	continue_button.disabled = true
	
func change_state(new_state):
	current_state = new_state
