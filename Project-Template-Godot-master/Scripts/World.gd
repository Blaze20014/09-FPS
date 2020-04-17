extends Spatial

var basic_enemy = preload("res://Scene/Enemy.tscn")
onready var enemies = $Enemies

var x = 0

func _on_SpawnEnemy_timeout():
	var a = basic_enemy.instance()
	var num_x = rand_range(-28, 28)
	var num_z = rand_range(-28, 28)
	a.transform.origin = Vector3(num_x, 0, num_z)
	a.rotation_degrees = Vector3(0, rand_range(0, 361), 0)
	a.id = x + 1
	enemies.add_child(a)
	x += 1


func _on_TutorialLength_timeout():
	$Tutorial.visible = false
