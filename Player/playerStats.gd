extends Node

#problem: these vectors are infinite, can lead to memory hogging
var player_position = []
var player_anim = []
var facing_right = []

var memory = []

func set_memories_activity(change):
	for each in memory:
		each.is_active2 = change

func remove_old_positions(change):
	player_position.resize(change)
	player_anim.resize(change)
	facing_right.resize(change)
