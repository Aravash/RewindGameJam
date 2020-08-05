extends StaticBody2D

func _on_hurtbox_area_entered(area):
	PlayerStats.make_visible("WinUI")
