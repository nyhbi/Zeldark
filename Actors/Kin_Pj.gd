extends KinematicBody2D

var direction = Vector2()

var speed = 250
var distance = Vector2()
var velocity = Vector2()

var inventario = ["Vacio", "Vacio", "Vacio", "Vacio"]
var vida
var bombs
var keys

func _ready():
	inventario = get_node("/root/global").inventario
	vida = get_node("/root/global").vida
	bombs = get_node("/root/global").bombs
	keys = get_node("/root/global").keys
	
	pass

func _physics_process(delta):
	_movimientos(delta)
	actualizar_HUD()
	global.bombs = bombs
	global.vida = vida
	global.keys = keys
#

	
func _movimientos(delta):
	direction.x = int(Input.is_action_pressed("PLAYER_RIGHT"))-int(Input.is_action_pressed("PLAYER_LEFT"))
	direction.y = int(Input.is_action_pressed("PLAYER_DOWN"))-int(Input.is_action_pressed("PLAYER_UP"))
	
	_actualizarAnimaciones(direction)
		
	distance.x = speed*delta
	distance.y = speed*delta
	velocity.x = (direction.x*distance.x)/delta
	velocity.y = (direction.y*distance.y)/delta
	
	if direction.length() > 0:
		direction = direction.normalized() * velocity
	
	move_and_slide(velocity)
	
	
func _actualizarAnimaciones(direction):
#	if direction.x == 0 and direction.y == 0:
#		$Ani_Pj.animation = "Front"
	
	if direction.x > 0:
		$Spr_Pj/Ani_Pj.current_animation = "WalkRight"
#
	if direction.x < 0:
		$Spr_Pj/Ani_Pj.current_animation = "WalkLeft"
#
	if direction.y < 0:
		$Spr_Pj/Ani_Pj.current_animation = "WalkUp"
#
	if direction.y > 0:
		$Spr_Pj/Ani_Pj.current_animation = "WalkDown"
	
func get_item(item):
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
		return true
		
func actualizar_HUD():
	$HUD/CanvasLayer/Vida.frame = vida
	$HUD/CanvasLayer/Equipo/ItemA.animation = global.equipoA
	$HUD/CanvasLayer/Equipo/ItemB.animation = global.equipoB

	