extends KinematicBody2D

var vida = 2
var dondeMira = "WalkDown"

func _ready():
	print(str($Spr_Octorok/Ani_Octorok.current_animation))

	pass

func _process(delta):
	#Muere si se queda sin vida
	if (vida == 0):
		queue_free()
	
	#Guarda la ultima animacion realizada antes de detenerse
	if $Spr_Octorok/Ani_Octorok.current_animation != "":
		dondeMira = $Spr_Octorok/Ani_Octorok.current_animation
	
	#Activa la colision de rango si no está atacando
	if  comprobar_accion():
		$Rango_Disparo/Coll_Rango.disabled = false

func pierde_vida():
	#Pierde vida cuando el jugador le pega con la espada o la bomba
	pass

func _on_Rango_Disparo_body_entered(body):
	#Cuando el jugador entra en el rango de colision de disparo, dispara
	if(body.get_collision_layer_bit(1)):
		if comprobar_accion():
			dispara()
			print("Dispara")

func dispara():
	#Direccion de la animacion cuando ataca
	if dondeMira == "WalkRight" or dondeMira == "FightRight":
		$Spr_Octorok/Ani_Octorok.current_animation = "FightRight"

	if dondeMira == "WalkLeft" or dondeMira == "FightLeft":
		$Spr_Octorok/Ani_Octorok.current_animation = "FightLeft"

	if dondeMira == "WalkUp" or dondeMira == "FightUp":
		$Spr_Octorok/Ani_Octorok.current_animation = "FightUp"

	if dondeMira == "WalkDown" or dondeMira == "FightDown":
		$Spr_Octorok/Ani_Octorok.current_animation = "FightDown"

func comprobar_accion():
	#Comprueba si se está desarrollando una accion y desactiva la colision de rango en caso de ser afirmativo
	if $Spr_Octorok/Ani_Octorok.current_animation == "FightRight":
		$Rango_Disparo/Coll_Rango.disabled = true
		return false
	if $Spr_Octorok/Ani_Octorok.current_animation == "FightLeft":
		$Rango_Disparo/Coll_Rango.disabled = true
		return false
	if $Spr_Octorok/Ani_Octorok.current_animation == "FightDown":
		$Rango_Disparo/Coll_Rango.disabled = true
		return false
	if $Spr_Octorok/Ani_Octorok.current_animation == "FightUp":
		$Rango_Disparo/Coll_Rango.disabled = true
		return false

	return true

