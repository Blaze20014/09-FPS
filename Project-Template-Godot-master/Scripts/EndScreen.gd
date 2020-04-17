extends Control

onready var label = get_node("Score")

func _ready():
	label.text = label.text % PlayerData.score
