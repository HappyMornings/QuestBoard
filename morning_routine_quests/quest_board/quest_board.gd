class_name QuestBoard
extends Control

"""
This is the visual board of where quest papers for the morning routine
will be placed. It manages the structure in which these
quest papers are arranged to be looked at.
And provides access to reading the quest papers and
claiming their completion. (Emphasis on claiming the reward,
not selecting a quest to start.) 

The effects of claiming a reward are controlled here.

Claimed quest papers will simply be marked off on the quest board
It is only when the quest board viewing is exitted that
reopening it would have marked of quest disappear.
"""

# I need to control the gap between quest paper
# Solution: 
#	Quest paper has its own inherit spacing
#	The QuestPaperGrid also has its own margin to control
#	To make it simply, each quest board holds up to 10 papers
#	5 columns, 2 papers therefore per column.

# I need to control the size of quest paper so it does not stretch weirdly
# Solution:
# 	Quest Paper has an aspect ratio container to ensure this.

var quest_paper_tscn: PackedScene = preload("res://morning_routine_quests/quest_board/quest_paper.tscn")
var quest_paper_overview_tscn: PackedScene = preload("res://morning_routine_quests/quest_board/quest_paper_overview.tscn")

@onready var questPaperGrid = $QuestBoardMargin/QuestPaperGrid

var isInstantiated: bool = false
var questPapers: Array[QuestPaper]

func instantiateQuestBoard(papers: Array[Quest]) -> void:
	if len(papers) > 10:
		push_warning("Number of papers per quest board should be limited to 10!")
	
	for paper in papers:
		var questPaper: QuestPaper = quest_paper_tscn.instantiate()
		questPaper.instantiateQuestPaper(paper)
		questPapers.append(questPaper)
	
	isInstantiated = true

# TODO: Outcome when there are no quests
func _ready() -> void:
	if !isInstantiated:
		push_error("Quest Board added to tscn tree without calling 'instantiateQuestBoard' first!")
	
	for paper in questPapers:
		var questPaper = create_quest_paper(paper)
		questPaperGrid.add_child(questPaper)
		#questPaperGrid.add_child(paper)

func create_quest_paper(paper: QuestPaper) -> QuestPaperOverview:
	var paperOverview: QuestPaperOverview = quest_paper_overview_tscn.instantiate()
	paperOverview.instantiateQuestPaperOverview(paper)
	return paperOverview
