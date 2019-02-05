extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	$ButtonNewGame.grab_focus()
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass



func _on_ButtonNewGame_pressed():
	get_tree().change_scene("res://Levels/Level1.tscn")


func _on_ButtonContinue_pressed():
	get_tree().change_scene("res://SaveMenu.tscn")


func _on_ButtonExit_pressed():
	get_tree().quit()
