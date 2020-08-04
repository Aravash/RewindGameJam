extends KinematicBody2D

var move_dir = 0
export var move_speed = 20

func _physics_process(delta):
	move_dir = 0
	if Input.is_action_pressed("move_left") && position.x > -10:
		move_dir -= 1
	if Input.is_action_pressed("move_right") && position.x < 10:
		move_dir += 1
	
	print(position.x)
	move_and_slide(Vector2(move_dir * move_speed, 0), Vector2(0, -1))
