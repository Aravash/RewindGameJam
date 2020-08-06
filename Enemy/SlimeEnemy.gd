extends "res://moving_entity.gd"

var player

onready var anim_tree = $AnimationTree
onready var anim_state = anim_tree.get("parameters/playback")

onready var timer = $Timer
var timeout = false
var last_position = Vector2.ZERO

enum{
	ALIVE,
	DEAD
}

var state = ALIVE

# warning-ignore:unused_argument
func _physics_process(delta):
	move_dir = 0
	
	match(state):
		ALIVE: do_move()
		DEAD: anim_state.travel("die")
	
	grounded = is_on_floor()
	_do_gravity()
	# warning-ignore:return_value_discarded
	move_and_slide(Vector2(move_dir * move_speed, y_velo), Vector2(0, -1))

func do_move():
	
	anim_state.travel("walk")
	if facing_right:
		move_dir += 1
	else: move_dir -= 1
	
	if timeout:
		if _near_enough(last_position.x, position.x, 0.01):
			_flip()
			print("flipped slime")
			timeout = false
			timer.start(0.1)
	last_position.x = position.x

#checks if the two points are near enough based on the 3rd input
func _near_enough(point_a, point_b, threshold):
	return point_a + threshold >= point_b && point_a - threshold <= point_b

func _on_hurtbox_area_entered(area):
	player = area.get_parent().get_parent()
	$Stats.health -= area.damage

func _on_Stats_no_health():
	state = DEAD
	$Position2D/hitbox.queue_free()
	player.create_memory()

func _on_Timer_timeout():
	timeout = true
