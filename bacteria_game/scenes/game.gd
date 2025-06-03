extends Node2D

var score = 0
var slime = load("res://scenes/slime.tscn")
@onready var timer: Timer = $Timer
@onready var camera_2d: Camera2D = $Camera2D
@onready var score_label: Label = $ScoreLabel
@onready var pickup_sound: AudioStreamPlayer = $PickupSound

func _ready() -> void:
	timer.start()


func _on_timer_timeout() -> void:
	var new_slime = slime.instantiate()
	add_child(new_slime)
	new_slime.position = Vector2(
		randf_range(camera_2d.limit_left, camera_2d.limit_right),
		randf_range(camera_2d.limit_top, camera_2d.limit_bottom)
	)
	print("slime spawn")
	print(new_slime.position)
	
func add_point():
	score += 1
	pickup_sound.play()
	score_label.text = "Score: " + str(score)
	
	
