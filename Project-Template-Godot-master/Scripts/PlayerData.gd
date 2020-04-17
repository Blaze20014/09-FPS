extends Node

onready var points_label = $"/root/World/UI/PointsLabel"

var score = 0

func set_score(value):
	score += value
	points_label.text = "Score: %s" % score
