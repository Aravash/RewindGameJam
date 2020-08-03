extends Control

onready var MainMenu = $MainMenu
onready var LevelSelectMenu = $LevelSelect

func _on_SelectLevel_pressed():
	MainMenu.visible = false
	LevelSelectMenu.visible = true

func _on_Exit_pressed():
	get_tree().quit()

func _on_ReturnToMain_pressed():
	MainMenu.visible = true
	LevelSelectMenu.visible = false

func _on_Test_pressed():
	get_tree().change_scene("res://scenes/level.tscn")
