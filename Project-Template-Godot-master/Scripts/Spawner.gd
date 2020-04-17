extends Node

func _ready():
	var rand = RandomNumberGenerator.new()
	var scene = load("res/Scene/Enemy.tscn")
	
	var screen_size = get_
