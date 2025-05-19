class_name QuestPaper
extends Control

"""
The quest paper where the quests and its reward are written on.
"""

@onready var questIcon: TextureRect = $AspectRatioContainer/VBoxContainer/QuestIcon
@onready var questNameLabel: Label = $AspectRatioContainer/VBoxContainer/QuestName
@onready var questDescription: Label =$AspectRatioContainer/VBoxContainer/QuestDescription
@onready var questReward: Label = $AspectRatioContainer/VBoxContainer/QuestReward
@onready var exit: Button = $AspectRatioContainer/PanelContainer/Exit

var isInstantiated: bool = false
var icon: CompressedTexture2D
var questName: String
var description: String
var reward: int

func instantiateQuestPaper(quests: Quest) -> void:
	icon = quests.questIcon
	questName = quests.questName
	description = quests.questDescription
	reward = quests.questReward
	isInstantiated = true

func _ready() -> void:
	if !isInstantiated:
		push_error("Quest Board added to tscn tree without calling 'instantiateQuestPaper' first!")
	
	questIcon.texture = icon
	questNameLabel.text = questName
	questDescription.text = description
	questReward.text = "Reward: " + str(reward)

func _on_exit_pressed() -> void:
	get_tree().root.remove_child(self)
