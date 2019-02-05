extends Control

func _ready():
	$ButtonNewGame.grab_focus()
	pass

func _on_ButtonNewGame_pressed():
	get_tree().change_scene("res://Levels/Level1.tscn")


func _on_ButtonContinue_pressed():
	get_tree().change_scene("res://SaveMenu.tscn")


func _on_ButtonExit_pressed():
	get_tree().quit()
