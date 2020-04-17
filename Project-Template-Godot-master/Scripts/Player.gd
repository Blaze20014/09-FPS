extends KinematicBody

export var speed = 10
export var acceleration = 5
export var gravity = .98
export var jump_power = 30
export var mouse_sensitivity = .3

onready var points_label = $"/root/World/UI/PointsLabel"
onready var health_label = $"/root/World/UI/HealthLabel"
onready var head = $Head
onready var camera = $Head/Camera

var score = 0
var health = 3
var velocity = Vector3()
var camera_x_rotation = 0
var cursor_visible = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		
		
		var x_delta = event.relative.y * mouse_sensitivity
		if camera_x_rotation + x_delta > -90 and camera_x_rotation + x_delta < 90:
			camera.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
			camera_x_rotation += x_delta

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if cursor_visible == false:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			cursor_visible = true
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _physics_process(delta):
	var head_basis = head.get_global_transform().basis
	var direction = Vector3()
	if Input.is_action_pressed("Forwards"):
		direction -= head_basis.z
	elif Input.is_action_pressed("Backwards"):
		direction += head_basis.z
		
	if Input.is_action_pressed("Left"):
		direction -= head_basis.x
	elif Input.is_action_pressed("Right"):
		direction += head_basis.x
		
	direction = direction.normalized()
	
	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta)
	velocity.y -= gravity
	
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y += jump_power
	velocity = move_and_slide(velocity, Vector3.UP)
	
func _on_Area_body_entered(body):
	if body.is_in_group("d") and $PainThreshold.time_left == 0 and health != 0:
		health -= 1
		health_label.set_text("Health: %d / 3" % health)
		$PainThreshold.start()
		$Regen.start()
	if health == 0:
		die()

func _on_Regen_timeout():
	if health < 3:
		health += 1
		health_label.set_text("Health: %d / 3" % health)
		$Regen.start()

func die():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene("res://Scene/EndScreen.tscn")

func set_score(points):
	score += points
	points_label.set_text("Score: %d" % score)
