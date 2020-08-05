extends Sprite

export(bool) var one_time = false

func _on_hurtbox_area_entered(area):
	area.get_parent().get_parent().create_memory()
	if one_time:
		$hurtbox.queue_free()
		$AnimationPlayer.play("broken")
