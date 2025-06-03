extends Node

@onready var quest_viewer_tscn: PackedScene = preload("res://quest_board/quest_viewer.tscn")

@export var quests: Array[Quest]

func _ready() -> void:
	var quest_viewer: QuestViewer = quest_viewer_tscn.instantiate()
	quest_viewer.instantiateQuestViewer(quests)
	self.add_child(quest_viewer)
