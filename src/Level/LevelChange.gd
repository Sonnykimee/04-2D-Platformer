extends Area2D

export(String, FILE, "*.tscn") var target

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_LevelChange_body_entered(body):
	if "Player" in body.name:
		get_tree().change_scene(target)
