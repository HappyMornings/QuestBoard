extends Node

@onready var quest_viewer_tscn: PackedScene = preload("res://questBoard/QuestViewer.tscn")

@export var quests: Array[Quest]

func _ready() -> void:
	var quest_viewer: QuestViewer = quest_viewer_tscn.instantiate()
	quest_viewer.instantiateQuestViewer(quests)
	self.add_child(quest_viewer)
