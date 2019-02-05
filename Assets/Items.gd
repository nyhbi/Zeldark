extends Area2D
export (String) var item

func _ready():
	#Actualiza la animación con el nombre del item
	$AnimatedSprite.animation = item

func _on_Items_body_entered(body):
	#Si el item colisiona con un cuerpo del tipo jugador, entonces el item desaparece.
	if (body.get_collision_layer_bit(1)):
		if(body.get_item(item)):
			queue_free()
		
		else:
			print("Ya tienes suficientes " + str(item) + "s.")
