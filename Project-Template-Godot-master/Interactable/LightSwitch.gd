extends Interactable

func get_interaction_text():
	return "Escape (2000 points)"

func interact():
	if PlayerData.score <= 2000:
		get_tree().change_scene("res://Scene/WinScreen.tscn")
