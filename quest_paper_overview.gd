class_name QuestPaperOverview
extends Control

"""
The item displayed on the quest board, where each is linked
to its corresponding quests.
"""

@onready var questIcon: TextureRect = $AspectRatioContainer/QuestIcon
@onready var zoomInButton: Button = $AspectRatioContainer/ZoomInButton
@onready var completeQuestButton: Button = $AspectRatioContainer/PanelContainer/CompleteQuestButton
@onready var completedIndicator: ColorRect = $AspectRatioContainer/ColorRect2

var questPaper: QuestPaper
var icon: CompressedTexture2D

func instantiateQuestPaperOverview(quest: QuestPaper):
	questPaper = quest
	icon = questPaper.icon

func _ready() -> void:
	questIcon.texture = icon

func _on_zoom_in_button_pressed() -> void:
	print("Pressed button at", self.position)
	get_tree().root.add_child(questPaper)

func _on_complete_quest_button_pressed() -> void:
	# Disable the Quest on the Overview
	zoomInButton.disabled = true
	completeQuestButton.disabled = true
	completedIndicator.visible = true
	# TODO: Do special effects
	# TODO: Update the internal quests list
