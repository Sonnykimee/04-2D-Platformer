extends KinematicBody2D

var SPEED = 100
var GRAV = 40
var FLOOR = Vector2(0, -1)

var vel = Vector2()
var dir = 1


func _ready():
	pass


func _physics_process(delta):
	vel.x = SPEED * dir
	
	if dir == 1:
		$Sprite.flip_h = false
	else:
		$Sprite.flip_h = true
	
	vel.y += GRAV
	
	vel = move_and_slide(vel, FLOOR)


	if is_on_wall():
		dir = dir * -1
		$FloorRayCast.position.x *= -1
		
	if $FloorRayCast.is_colliding() == false:
		dir = dir * -1
		$FloorRayCast.position.x *= -1

	if get_slide_count() > 0:
		for i in range(get_slide_count()):
			if "Player" in get_slide_collision(i).collider.name:
				get_slide_collision(i).collider.dead()
