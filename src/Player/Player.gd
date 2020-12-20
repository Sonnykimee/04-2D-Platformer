extends KinematicBody2D

# Initialize variables
var SPEED = 250
var GRAV = 40
var JUMP_POW = -550
var FLOOR = Vector2(0, -1)

var vel = Vector2()
var on_ground = false
var dir = 0
var is_dead = false
	
var score = 0

# Save/Load variables
var path = "user://save.json"

var default_data = {
	"score" : 0,
	"level" : "res://src/Level/Level01.tscn"
}

var data = {}

func _process(delta):
	$Label.text = "Score: " + str(score)
	$Label.set_global_position($ScorePosition.global_position)

func _physics_process(delta):
	
	if not is_dead:
		# Updates newly pressed key
		if Input.is_action_just_pressed("ui_right"):
			dir = 1
		elif Input.is_action_just_pressed("ui_left"):
			dir = -1
		
		# Right, left movement
		if Input.is_action_pressed("ui_right") && dir == 1:
			vel.x = SPEED
			$Sprite.flip_h = false
		elif Input.is_action_pressed("ui_left") and dir == -1:
			vel.x = -SPEED
			$Sprite.flip_h = true
		else:
			vel.x = 0
		
		# Jump if player is on the ground
		if Input.is_action_pressed("ui_up"):
			if on_ground:
				vel.y = JUMP_POW
				on_ground = false
		
		# Falls down by GRAV every frame
		vel.y += GRAV
		
		# Check if player is on the ground and changes on_ground varaible
		if is_on_floor():
			on_ground = true
		else:
			on_ground = false
			
		vel = move_and_slide(vel, FLOOR)
		
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "Enemy" in get_slide_collision(i).collider.name:
					dead()


func dead():
	is_dead = true
	vel = Vector2(0, 0)
	$CollisionShape2D.disabled = true
	get_tree().change_scene("res://src/Level/Level01.tscn")


func jelly():
	score += 10


# Save/Load functions

# Called when the node enters the scene tree for the first time.
func _ready():
	#save_game()
	#load_game()
	pass
	

func load_game():
	var file = File.new()
	
	if not file.file_exists(path):
		return
	
	file.open(path, file.READ)
	
	var text = file.get_as_text()
	data = parse_json(text)
	
	score = data["score"]
	
	file.close()
	

func save_game():
	data["score"] = score
	
	var file
	
	file = File.new()
	
	file.open(path, File.WRITE)
	
	file.store_line(to_json(data))
	
	file.close()
