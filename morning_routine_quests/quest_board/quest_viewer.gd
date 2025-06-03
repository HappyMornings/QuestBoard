class_name QuestViewer
extends Control

"""
This control node controls the number of QuestBoards to use.
The controls to move between QuestBoards.
It is where we can visually see all the Quest and use the 
functionality of the QuestBoards.
"""

var quest_board_tscn: PackedScene = preload("res://morning_routine_quests/quest_board/quest_board.tscn")

@onready var questBoardBox = $HBoxContainer/QuestBoardBox
@onready var leftButton: Button = $HBoxContainer/PanelContainer/LeftButton
@onready var rightButton: Button = $HBoxContainer/PanelContainer2/RightButton

var isInstantiated: bool = false
var questBoards: Array[QuestBoard] # All the current quests related to morning routine
var currentBoardIndex: int = 0

func instantiateQuestViewer(quests: Array[Quest]) -> void:
	var counter = 0
	var quest_accumulator: Array[Quest] = []
	var questBoard: QuestBoard = quest_board_tscn.instantiate()
	
	for quest in quests:
		if counter == 10: # Go to next QuestBoard
			questBoard.instantiateQuestBoard(quest_accumulator)
			questBoards.append(questBoard)
			questBoard = quest_board_tscn.instantiate()
			
			# Reset for next batch
			counter = 0
			quest_accumulator = []
			
		quest_accumulator.append(quest)
		counter += 1
	
	# After loop ends — only add last board if it has quests OR if no boards were added
	if not quest_accumulator.is_empty() or questBoards.is_empty():
		questBoard.instantiateQuestBoard(quest_accumulator)
		questBoards.append(questBoard)
		
	isInstantiated = true

func _ready() -> void:
	if !isInstantiated:
		push_error("Quest Viewer added to tscn tree without calling 'instantiateQuestViewer' first!")
	
	#TODO: Actually implement swapping between them
	for board in questBoards:
		questBoardBox.add_child(board)
		
	updateBoard() # Guranteed to have 1
	updateButtons()

func updateBoard():
	for i in range(questBoards.size()):
		questBoards[i].visible = i == currentBoardIndex

func updateButtons():
	leftButton.disabled = currentBoardIndex == 0
	rightButton.disabled = currentBoardIndex == questBoards.size() - 1


func _on_left_button_pressed() -> void:
	print("Go left")
	if currentBoardIndex > 0:
		currentBoardIndex -= 1
		updateBoard()
		updateButtons()

func _on_right_button_pressed() -> void:
	print("Go right")
	if currentBoardIndex < questBoards.size() - 1:
		currentBoardIndex += 1
		updateBoard()
		updateButtons()
