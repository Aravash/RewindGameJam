extends "res://moving_entity.gd"

var player

onready var anim_tree = $AnimationTree
onready var anim_state = anim_tree.get("parameters/playback")

onready var timer = $Timer
var timeout = false
var last_position = Vector2.ZERO

func _physics_process(delta):
	grounded = is_on_floor()
	_do_gravity()
	move_dir = 0
	
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
	
# warning-ignore:return_value_discarded
	move_and_slide(Vector2(move_dir * move_speed, y_velo), Vector2(0, -1))

#checks if the two points are near enough based on the 3rd input
func _near_enough(point_a, point_b, threshold):
	return point_a + threshold >= point_b && point_a - threshold <= point_b

func _on_hurtbox_area_entered(area):
	player = area.get_parent().get_parent()
	$Stats.health -= area.damage

func _on_Stats_no_health():
	$Position2D/hurtbox.create_hitEffect()
	player.create_memory()
	queue_free()

func _on_Timer_timeout():
	timeout = true
