extends Node2D

var stats = PlayerStats
var is_active = false
onready var i = stats.player_position.size() - 1

onready var sprite = $Sprite
onready var anim_tree = $AnimationTree
onready var anim_state = anim_tree.get("parameters/playback")

func _ready():
	$Delay.start(rand_range(1, 4))

func _on_PositionTimer_timeout():
	if !is_active: return
	set_global_position(stats.player_position[i])
	anim_state.travel(stats.player_anim[i])
	if stats.facing_right[i] != stats.facing_right[i-1]:
		sprite.flip_h = !sprite.flip_h
	i += 1

func _on_Delay_timeout():
	print("timer out")
	$hurtbox/CollisionPolygon2D.disabled = false
	is_active = true
#you only really die when there are no more memories of you
func _on_hurtbox_area_entered(_area):
	$hurtbox.create_hitEffect()
	queue_free()
