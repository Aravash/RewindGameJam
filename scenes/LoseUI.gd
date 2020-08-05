extends Control

export(String, FILE, "level*.tscn") var file_path

func _on_Retry_pressed():
	get_tree().change_scene(file_path)


func _on_MainMenu_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")
