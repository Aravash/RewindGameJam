extends Node

#problem: these vectors are infinite, can lead to memory hogging
var player_position = []
var player_anim = []
var facing_right = []

var memory = []
var player_is_hit = false

func remove_old_positions(change):
	player_position.resize(change)
	player_anim.resize(change)
	facing_right.resize(change)

func make_visible(element):
	get_tree().get_root().get_child(1).get_node("CanvasLayer").get_node(element).visible = true
