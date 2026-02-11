extends Node2D

enum ButtonType {
	START,
	QUIT
}

var current_button_type = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_start_pressed() -> void:
	current_button_type = ButtonType.START
	$FadeTransition.show()
	$FadeTransition/Timer.start()
	$FadeTransition/AnimationPlayer.play("fade_in")

func _on_quit_pressed() -> void:
	current_button_type = ButtonType.QUIT
	$FadeTransition.show()
	$FadeTransition/Timer.start()
	$FadeTransition/AnimationPlayer.play("fade_in")

func _on_timer_timeout() -> void:
	match current_button_type:
		ButtonType.START:
			get_tree().change_scene_to_file("res://scenes/selection.tscn")
		ButtonType.QUIT:
			get_tree().quit()
