extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	$ButtonBack.grab_focus()
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_ButtonBack_pressed():
	get_tree().change_scene("res://MainMenu.tscn")


func _on_ButtonSlot1_pressed():
	pass # replace with function body


func _on_ButtonSlot2_pressed():
	pass # replace with function body
