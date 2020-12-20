extends Area2D


func _on_Jelly_body_entered(body):
	if "Player" in body.name:
		body.jelly()
		queue_free()
