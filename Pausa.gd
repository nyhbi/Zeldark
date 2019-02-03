extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	pass

func _process(delta):
	$N_Llaves.text = "x " + (str(global.keys))
	$N_Bombas.text = "x " + (str(global.bombs))
	$Inventario/Slot1.animation = global.inventario[3]
	$Inventario/Slot2.animation = global.inventario[2]
	$Inventario/Slot3.animation = global.inventario[1]
	$Inventario/Slot4.animation = global.inventario[0]
	pass

func _on_Continue_pressed():
	unpause()

func _on_Save_pressed():
	pass # replace with function body

func _on_Quit_pressed():
	get_tree().quit()

func unpause():
	hide()
	get_tree().paused = false
