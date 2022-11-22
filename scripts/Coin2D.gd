extends Area2D

func _on_Coin2D_body_entered(body):
	if body.get_name() == 'knight':	
		body.addCoin()		
		queue_free()

