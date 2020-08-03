extends "res://moving_entity.gd"

var player

func _physics_process(delta):
	grounded = is_on_floor()
	_do_gravity()
	move_and_slide(Vector2(move_dir * move_speed, y_velo), Vector2(0, -1))

func _on_hurtbox_area_entered(area):
	player = area.get_parent().get_parent()
	$Stats.health -= area.damage


func _on_Stats_no_health():
	$Position2D/hurtbox.create_hitEffect()
	player.create_memory()
	queue_free()
