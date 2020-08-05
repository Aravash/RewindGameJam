extends KinematicBody2D

var move_dir = 0
var t = 0
export var move_speed = 20
var dt = 0

var is_panning = false

func _physics_process(delta):
	delta = dt
	move_dir = 0
	if Input.is_action_pressed("move_left") && position.x > -10:
		move_dir -= 1
	if Input.is_action_pressed("move_right") && position.x < 10:
		move_dir += 1
	
	move_and_slide(Vector2(move_dir * move_speed, 0), Vector2(0, -1))

#returns true if camera has reached target_pos
func pan_to_memory(player_pos, target_pos):
	t += dt * 0.4
	
	position = player_pos.linear_interpolate(target_pos, t)
	
	print(position == target_pos)
	return position == target_pos
