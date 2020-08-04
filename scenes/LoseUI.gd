extends Control


func _on_Retry_pressed():
	get_tree().reload_current_scene()


func _on_MainMenu_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")
