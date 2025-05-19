extends Node2D

var length = 100
var startPos: Vector2
var currentPos: Vector2
var swiping = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("press"):
		if !swiping:
			swiping = true
			startPos = get_global_mouse_position()
			print("Start position: ", startPos)
	if Input.is_action_pressed("press"):
		if swiping:
			currentPos = get_global_mouse_position()
			if startPos.distance_to(currentPos) >= length:
				print("Swipe Detected!")
				swiping = false
	else:
		swiping = false
