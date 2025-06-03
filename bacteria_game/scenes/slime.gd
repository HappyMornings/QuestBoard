extends Area2D

@onready var game: Node2D = $".."

func _on_body_entered(body: Node2D) -> void:
	game.add_point()
	queue_free()
