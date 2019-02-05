extends Area2D
export (String) var item

func _ready():
	$AnimatedSprite.animation = item

func _on_Items_body_entered(body):
	if (body.get_collision_layer_bit(1)):
		if(body.get_item(item)):
			print("Inventario: " + str(body.inventario))
			print("Vida: " + str(body.vida))
			print("Bombas: " + str(body.bombs))
			print("Llaves: " + str(body.keys))
			queue_free()
		
		else:
			print("Ya tienes suficientes " + str(item) + "s.")
