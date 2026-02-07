extends CanvasLayer

@onready var textbox_container = $TextboxContainer
@onready var textfield = $TextboxContainer/MarginContainer/VBoxContainer/HBoxContainer/Text
@onready var continue_button = $TextboxContainer/MarginContainer/VBoxContainer/HBoxContainer2/Button

enum State {
	READY,
	READING,
	FINISHED
}

var tween = create_tween()
var current_state = State.READY

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.finished.connect(_on_tween_finished)
	continue_button.pressed.connect(_on_continue_pressed)
	
	hide_textbox()
	
func _on_continue_pressed():
	match current_state:
		State.FINISHED:
			change_state(State.READY)
			hide_textbox()
	
func set_text(text):
	textfield.text = text
	change_state(State.READING)
	show_textbox()

	tween.tween_property(textfield, "visible_characters", len(text), 1.2)
	
func _on_tween_finished():
	continue_button.show()
	change_state(State.FINISHED)
	
func hide_textbox():
	continue_button.hide()
	textbox_container.hide()
	
func show_textbox():
	textbox_container.show()
	
func change_state(new_state):
	current_state = new_state
