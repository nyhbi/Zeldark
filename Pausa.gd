extends Control

var seccion = ["Menu", "Mapa", "Items"]
var punteroMenu = 0
var indice = 0

func _ready():
	$Inventario/HadaSelec/Ani_Hada.current_animation = "Hada"
	pass

func _process(delta):
	if(get_tree().paused == true):
		graficar_Menu()
		movimiento_Menu()

func _on_Continue_pressed():
	hide()
	get_tree().paused = false
	global.pausa = false

func _on_Save_pressed():
	pass # replace with function body

func _on_Quit_pressed():
	get_tree().quit()
	
func movimiento_Menu():
	#MOVIMIENTO POR SECCIONES DEL MENU
	if(	Input.is_action_just_pressed("PLAYER_R_TRIGGER") && punteroMenu !=2):
		punteroMenu += 1
	if(	Input.is_action_just_pressed("PLAYER_L_TRIGGER") && punteroMenu !=0):
		punteroMenu -= 1
	#MOVIMIENTO EN SECCION ITEMS 
	if(seccion[punteroMenu] == "Items"):
		if(Input.is_action_just_pressed("PLAYER_RIGHT")):
			if(indice == 0):
				indice = 1
			if(indice == 2):
				indice = 3
		if(	Input.is_action_just_pressed("PLAYER_LEFT")):
			if(indice == 1):
				indice = 0
			if(indice == 3):
				indice =2
		if(Input.is_action_just_pressed("PLAYER_DOWN")):
			if(indice == 0):
				indice = 2
			if(indice == 1):
				indice = 3
		if(Input.is_action_just_pressed("PLAYER_UP")):
			if(indice == 2):
				indice = 0
			if(indice == 3):
				indice = 1
		if(Input.is_action_just_pressed("PLAYER_BUTTON_A")):
			if(global.punteroA == indice):
				global.punteroA = 4
			else:
				global.punteroA = indice
			equipar()
		if(Input.is_action_just_pressed("PLAYER_BUTTON_B")):
			if(global.punteroB == indice):
				global.punteroB = 4
			else:
				global.punteroB = indice
			equipar()

	#MOVIMIENTO EN SECCION MENU
	if(seccion[punteroMenu] == "Menu"):
		#Qué boton selecciona dependiendo del indice
		if(indice == 0):
			$Continue.grab_focus()
		if(indice == 1):
			$Save.grab_focus()
		if(indice == 2):
			$Quit.grab_focus()
		#Movimiento del hada dependiendo del indice
		if(Input.is_action_just_pressed("PLAYER_DOWN")):
			if(indice != 2):
				indice += 1
		if(Input.is_action_just_pressed("PLAYER_UP")):
			if(indice != 0):
				indice -= 1

	if(seccion[punteroMenu] == "Mapa"):
		indice = 0
		$Continue.release_focus()
		$Save.release_focus()
		$Quit.release_focus()
		
func equipar():
	if(global.punteroA != 4):
		global.equipoA = global.inventario[global.punteroA]
	else:
		global.equipoA = "Vacio"
		
	if(global.punteroB != 4):
		global.equipoB = global.inventario[global.punteroB]
	else:
		global.equipoB = "Vacio"
	
func graficar_Menu():
	$N_Llaves.text = "x " + (str(global.keys))
	$N_Bombas.text = "x " + (str(global.bombs))
	$Inventario/Slot1.animation = global.inventario[0]
	$Inventario/Slot2.animation = global.inventario[1]
	$Inventario/Slot3.animation = global.inventario[2]
	$Inventario/Slot4.animation = global.inventario[3]
	$Inventario/SeleccionA.frame = global.punteroA
	$Inventario/SeleccionB.frame = global.punteroB
	$Inventario/Vida.frame = global.vida
	$Inventario/Equipo/ItemA.animation = global.equipoA
	$Inventario/Equipo/ItemB.animation = global.equipoB
	
	#Posicion del hadix
	if(seccion[punteroMenu] == "Items"):
		if(indice == 0):
			$Inventario/HadaSelec.position.x = 918
			$Inventario/HadaSelec.position.y = 241
		if(indice == 1):
			$Inventario/HadaSelec.position.x = 1006
			$Inventario/HadaSelec.position.y = 241
		if(indice == 2):
			$Inventario/HadaSelec.position.x = 918
			$Inventario/HadaSelec.position.y = 341
		if(indice == 3):
			$Inventario/HadaSelec.position.x = 1006
			$Inventario/HadaSelec.position.y = 341

	if(seccion[punteroMenu] == "Mapa"):
		$Inventario/HadaSelec.position.x = 738
		$Inventario/HadaSelec.position.y = 442

	if(seccion[punteroMenu] == "Menu"):
		if(indice == 0):
			$Inventario/HadaSelec.position.x = 371
			$Inventario/HadaSelec.position.y = 245
		if(indice == 1):
			$Inventario/HadaSelec.position.x = 321
			$Inventario/HadaSelec.position.y = 334
		if(indice == 2):
			$Inventario/HadaSelec.position.x = 321
			$Inventario/HadaSelec.position.y = 438
