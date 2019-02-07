extends KinematicBody2D

var direction = Vector2()

var speed = 250
var distance = Vector2()
var velocity = Vector2()

var inventario = ["Vacio", "Vacio", "Vacio", "Vacio"]
var vida
var bombs
var keys

var dondeMira = "WalkDown"

func _ready():
	#Sincroniza las variables del personaje con las variables globales
	inventario = get_node("/root/global").inventario
	vida = get_node("/root/global").vida
	bombs = get_node("/root/global").bombs
	keys = get_node("/root/global").keys


func _physics_process(delta):
	_movimientos(delta)
	actualizar_HUD()
	global.bombs = bombs
	global.vida = vida
	global.keys = keys


func _movimientos(delta):
	
	direction.x = int(Input.is_action_pressed("PLAYER_RIGHT"))-int(Input.is_action_pressed("PLAYER_LEFT"))
	direction.y = int(Input.is_action_pressed("PLAYER_DOWN"))-int(Input.is_action_pressed("PLAYER_UP"))
	
	if comprobar_accion():
		_actualizarAnimaciones(direction)
		accion_boton()
		
		distance.x = speed*delta
		distance.y = speed*delta
		velocity.x = (direction.x*distance.x)/delta
		velocity.y = (direction.y*distance.y)/delta
	
		if direction.length() > 0:
			direction = direction.normalized() * velocity
	
		move_and_slide(velocity)
	
	
	
func _actualizarAnimaciones(direction):
	#Actualiza las animaciones dependiendo de la accion realizada
	if direction.x > 0 and direction.y == 0:
		$Spr_Pj/Ani_Pj.current_animation = "WalkRight"

	if direction.x < 0 and direction.y == 0:
		$Spr_Pj/Ani_Pj.current_animation = "WalkLeft"

	if direction.y < 0 and direction.x == 0:
		$Spr_Pj/Ani_Pj.current_animation = "WalkUp"

	if direction.y > 0 and direction.x == 0:
		$Spr_Pj/Ani_Pj.current_animation = "WalkDown"
	
	#Direcciones diagonales
	if direction.x < 0 and direction.y < 0:
		$Spr_Pj/Ani_Pj.current_animation = "WalkUp"

	if direction.x > 0 and direction.y < 0:
		$Spr_Pj/Ani_Pj.current_animation = "WalkUp"

	if direction.x > 0 and direction.y > 0:
		$Spr_Pj/Ani_Pj.current_animation = "WalkDown"

	if direction.x < 0 and direction.y > 0:
		$Spr_Pj/Ani_Pj.current_animation = "WalkDown"

	#Guarda la ultima animacion realizada antes de detenerse
	if $Spr_Pj/Ani_Pj.current_animation != "":
		dondeMira = $Spr_Pj/Ani_Pj.current_animation
	
	
func get_item(item):
	#Acciones que realiza cuando colisiona con un objeto de la escena item
	var slotVacio = null
	
	for i in range(4):
		if(inventario[i] == "Vacio"):
			slotVacio = i
			
	if(slotVacio == null):
		return false
	
	if(item == "Vida" && vida < 6):
		vida += 1
		return true

	if(item == "Bomba" && bombs < 5):
		if(bombs == 0):
			inventario[slotVacio] = "Bomba"
		bombs += 1
		return true
	
	if(item != "Vida" && item != "Bomba"):
		inventario[slotVacio] = item
		if(item == "Llave"):
			keys +=1
		return true

func accion_boton():
	#Acciones que realiza el personaje dependiendo del item equipado y el boton presionado
	if(Input.is_action_just_pressed("PLAYER_BUTTON_A")):
		if global.equipoA == "Espada":
			atacar()
		if global.equipoA == "Bomba":
			pass
		if global.equipoA == "Llave":
			pass
		if global.equipoA == "Botas":
			pass
		
	if(Input.is_action_just_pressed("PLAYER_BUTTON_B")):
		if global.equipoB == "Espada":
			atacar()
		if global.equipoB == "Bomba":
			pass
		if global.equipoB == "Llave":
			pass
		if global.equipoB == "Botas":
			pass
			
func atacar():
	#Direccion de la animacion cuando ataca
	if dondeMira == "WalkRight" or dondeMira == "FightRight":
		$Spr_Pj/Ani_Pj.current_animation = "FightRight"
#
	if dondeMira == "WalkLeft" or dondeMira == "FightLeft":
		$Spr_Pj/Ani_Pj.current_animation = "FightLeft"
#
	if dondeMira == "WalkUp" or dondeMira == "FightUp":
		$Spr_Pj/Ani_Pj.current_animation = "FightUp"
#
	if dondeMira == "WalkDown" or dondeMira == "FightDown":
		$Spr_Pj/Ani_Pj.current_animation = "FightDown"

	#Dirección del colisionador cuando ataca
	if dondeMira == "WalkRight" or dondeMira == "FightRight":
		$Coll_Atk.rotation_degrees = 180
#
	if dondeMira == "WalkLeft" or dondeMira == "FightLeft":
		$Coll_Atk.rotation_degrees = 0
#
	if dondeMira == "WalkUp" or dondeMira == "FightUp":
		$Coll_Atk.rotation_degrees = 90
#
	if dondeMira == "WalkDown" or dondeMira == "FightDown":
		$Coll_Atk.rotation_degrees = 270

func comprobar_accion():
	#Comprueba si se está desarrollando una accion
	if $Spr_Pj/Ani_Pj.current_animation == "FightRight":
		$Coll_Atk.disabled = false
		return false
	if $Spr_Pj/Ani_Pj.current_animation == "FightLeft":
		$Coll_Atk.disabled = false
		return false
	if $Spr_Pj/Ani_Pj.current_animation == "FightDown":
		$Coll_Atk.disabled = false
		return false
	if $Spr_Pj/Ani_Pj.current_animation == "FightUp":
		$Coll_Atk.disabled = false
		return false
	else:
		$Coll_Atk.disabled = true
		
	return true
		
func actualizar_HUD():
	#Actualiza el HUD con el equipo actual y la vida actual
	$HUD/CanvasLayer/Vida.frame = vida
	$HUD/CanvasLayer/Equipo/ItemA.animation = global.equipoA
	$HUD/CanvasLayer/Equipo/ItemB.animation = global.equipoB

	