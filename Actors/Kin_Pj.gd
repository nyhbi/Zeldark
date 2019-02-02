extends KinematicBody2D

var direction = Vector2()

var speed = 250
var distance = Vector2()
var velocity = Vector2()

func _ready():

	pass

func _physics_process(delta):
	_movimientos(delta)

	
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
	if direction.x == 0 and direction.y == 0:
		$Ani_Pj.animation = "Front"
		
	
	if direction.x > 0:
		$Ani_Pj.flip_h = false
		$Ani_Pj.animation = "WalkSide"
		
	if direction.x < 0:
		$Ani_Pj.flip_h = true
		$Ani_Pj.animation = "WalkSide"
		
	if direction.y < 0:
		$Ani_Pj.animation = "WalkUp"
		
	if direction.y > 0:
		$Ani_Pj.animation = "WalkDown"
	

	