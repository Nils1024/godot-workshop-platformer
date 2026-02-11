extends Node2D

enum LEVELS {
	LEVEL_1,
	BACK
}

var current_button_type = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$FadeTransition/AnimationPlayer.play("fade_out")

func _on_level_1_pressed() -> void:
	current_button_type = LEVELS.LEVEL_1
	$FadeTransition.show()
	$FadeTransition/Timer.start()
	$FadeTransition/AnimationPlayer.play("fade_in")


func _on_timer_timeout() -> void:
	match current_button_type:
		LEVELS.LEVEL_1:
			get_tree().change_scene_to_file("res://scenes/game.tscn")
