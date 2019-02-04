extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	pausa()

	
	

func pausa():
	if (Input.is_action_pressed("PLAYER_PAUSE")):
		desactiva_hud()
		get_tree().paused = true
		$Pausa.show()
		global.pausa = true
		
		
func desactiva_hud():
		if global.pausa == false:
			$Kin_Pj/HUD/CanvasLayer/Equipo/ItemA.animation = "Vacio"
			$Kin_Pj/HUD/CanvasLayer/Equipo/ItemB.animation = "Vacio"
	