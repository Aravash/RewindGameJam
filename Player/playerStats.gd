extends Node

#problem: these vectors are infinite, can lead to memory hogging
var player_position = []
var player_anim = []
var facing_right = []

var memory = []
var player_is_hit = false

func set_memories_activity(change):
	var i = 0
	while(i < memory.size()):
		if memory[i] != null: 
			memory[i].is_active = change
		print("increment i")
		i += 1

func bababooey(target, change):
	for each in target.get_children():
		each.is_active = change

func remove_old_positions(change):
	player_position.resize(change)
	player_anim.resize(change)
	facing_right.resize(change)
