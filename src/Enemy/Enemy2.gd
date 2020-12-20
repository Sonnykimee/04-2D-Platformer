extends KinematicBody2D

onready var timer = get_node("Timer")
export var patrol_time = 2

func _ready():
	timer.set_wait_time(patrol_time)
	timer.start()


var SPEED = 150

var vel = Vector2()
var dir = 1

func _on_Timer_timeout():
	dir = dir * -1
	timer.set_wait_time(patrol_time)
	timer.start()


func _physics_process(delta):
	vel.x = SPEED * dir
		
	if dir == 1:
		$Sprite.flip_h = false
	else:
		$Sprite.flip_h = true
	
	vel = move_and_slide(vel)

	if get_slide_count() > 0:
		for i in range(get_slide_count()):
			if "Player" in get_slide_collision(i).collider.name:
				get_slide_collision(i).collider.dead()
				
