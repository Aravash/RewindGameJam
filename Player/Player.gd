extends "res://moving_entity.gd"
#this script overrides its parent's _flip() and _do_gravity() funcs

const Memory = preload("res://Memory.tscn")

onready var anim_tree = $AnimationTree
onready var anim_state = anim_tree.get("parameters/playback")
onready var pivot = $Position2D
onready var hurtbox = $Position2D/hurtbox
onready var posTimer = $PositionTimer

var memory_manager
var memory_delay_time = 1.5

var stats = PlayerStats
var anim_name = ""

enum{
	MOVE,
	OUCH,
	ATTACK
}

var state = MOVE

func _ready():
	._ready()
	memory_manager = get_parent().get_node("MemoriesManager")
	#stats.connect("no_health", self, "queue_free")

func _physics_process(delta):
	move_dir = 0
	
	match state:
		MOVE: _do_move(delta)
		OUCH: _get_hit(delta)
		ATTACK: _make_anim("attack")
	
	grounded = is_on_floor()
	_do_gravity()

func _do_gravity():
	y_velo += gravity
	if grounded and Input.is_action_just_pressed("jump"):
		y_velo = -jump_force
	if grounded and y_velo >= 5 or is_on_ceiling():
		y_velo = 5
	if y_velo > max_fall_speed:
		y_velo = max_fall_speed

func _anim_handler():
	if grounded:
		if move_dir == 0:
			_make_anim("idle")
		else:
			_make_anim("run")
	else: 
		if y_velo < 0:
			_make_anim("jump")
		else:
			_make_anim("fall")

func _do_move(_delta):
	if Input.is_action_pressed("move_left"):
		move_dir -= 1
	if Input.is_action_pressed("move_right"):
		move_dir += 1
	# warning-ignore:return_value_discarded
	move_and_slide(Vector2(move_dir * move_speed, y_velo), Vector2(0, -1))
	_anim_handler()
	_do_rotation()
	if Input.is_action_just_pressed("attack") && grounded: 
		state = ATTACK

func _do_rotation():
	if facing_right and move_dir > 0:
		_flip()
	if !facing_right and move_dir < 0:
		_flip()

func _flip():
	._flip()
	if facing_right: pivot.set_scale(Vector2(-1, 1))
	else: pivot.set_scale(Vector2(1, 1))

func _reset_state():
	state = MOVE

func _get_hit(_delta):
	_make_anim("hit")
	if facing_right:
		move_dir += 1
	else: move_dir -= 1
	#move_and_slide(Vector2(move_dir * move_speed, y_velo), Vector2(0, -1))

func _goto_recent_memory():
	if memory_manager.get_child_count() == 0:
		queue_free()
		return
	
	var old_memory = memory_manager.get_child(0)
	#this might be incorrect
	stats.remove_old_positions(old_memory.i + 1)
	global_position = old_memory.global_position
	#stats.set_memories_activity(true)
	#stats.bababooey(memory_manager, true)
	stats.player_is_hit = false
	state = MOVE
	y_velo = 5

func _on_hurtbox_area_entered(_area):
	#stats.set_memories_activity(false)
	#stats.bababooey(memory_manager, false)
	stats.player_is_hit = true
	state = OUCH
	y_velo = -jump_force/2

func create_memory():
	var obj = Memory.instance()
	obj.delay_time = memory_delay_time
	memory_manager.add_child(obj)
	obj.global_position = global_position
	obj.sprite.flip_h = facing_right
	memory_delay_time += 1
	stats.memory.push_back(obj)

func _make_anim(string):
	anim_state.travel(string)
	anim_name = string

func _on_PositionTimer_timeout():
	stats.player_position.push_back(get_global_position())
	stats.player_anim.push_back(anim_name)
	stats.facing_right.push_back(facing_right)
