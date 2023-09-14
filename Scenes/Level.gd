extends Node2D

var player_1_score = 0
var player_2_score = 0
var player_1_score_label
var player_2_score_label

func _update_player_scores():
	print("%s" % player_2_score)
	player_1_score_label.text = "%s" % player_1_score
	player_2_score_label.text = "%s" % player_2_score

func player_1_scored():
	player_1_score += 1
	_update_player_scores()
	
func player_2_scored():
	player_2_score += 1
	_update_player_scores()

func _on_Right_body_entered(_body):
	player_1_scored()

func _on_Left_body_entered(_body):
	player_2_scored()
	
func _ready():
	player_1_score_label = get_node("Player1Score")
	player_2_score_label = get_node("Player2Score")
	_update_player_scores()
