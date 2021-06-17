extends KinematicBody2D

export var gravity = 20
export var velocity = Vector2(500, 1000)
export var friction = 15
export var aceleration = 20
var _movimentation = Vector2(0,0)


func _physics_process(delta):
	var direction = Vector2(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
	Input.get_action_strength("move_right") - Input.get_action_strength("move_left"))
	
	if direction == Vector2(0,0):
		_movimentation = _movimentation.move_toward(Vector2(0,0), friction)
	else:
		_movimentation = _movimentation.move_toward(direction * velocity, 
		aceleration)
	
	move_and_slide(_movimentation)

