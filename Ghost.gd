extends KinematicBody2D
class_name Ghost

export var gravity = 20
export var velocity = Vector2(500, 1000)
export var friction = 15
export var aceleration = 20
var _movimentation = Vector2(0,0)

onready var animatedSprite = $AnimatedSprite


func _physics_process(delta):
	var direction = Vector2(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
	Input.get_action_strength("move_down") - Input.get_action_strength("move_up"))
	
	if direction == Vector2(0,0):
		_movimentation = _movimentation.move_toward(Vector2(0,0), friction)
	else:
		if direction.x > 0.0:
			animatedSprite.play("right")
		if direction.x < 0.0:
			animatedSprite.play("left")
		
		_movimentation = _movimentation.move_toward(direction * velocity, 
		aceleration)
	if _movimentation == Vector2(0,0):
		animatedSprite.play("default")
	print(_movimentation)
	move_and_slide(_movimentation)

