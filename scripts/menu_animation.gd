extends Node2D

@onready var anim := $AnimationPlayer
@onready var timer := $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_animation()
	
func _on_timer_timeout() -> void:
	play_animation()
	
func play_animation():
	anim.play("PlatformerAnimation")
	
	timer.wait_time = randf_range(5.0, 10.0)
	timer.start()
