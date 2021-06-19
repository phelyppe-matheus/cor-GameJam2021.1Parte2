extends KinematicBody2D
class_name Ghost

export var gravity = 30
#export var velocity = Vector2(600, 900)
export var velocity = Vector2(600, 600)
var friction = 100

var _movimentation = Vector2(0,0)
var player_gravity = true
onready var animatedSprite = $AnimatedSprite


func _physics_process(delta):
	
	#_movimentation = gravity(_movimentation)
	
	_movimentation = get_movimentation(_movimentation)
	
	setAnimations(_movimentation)
	
	_movimentation = move_and_slide(_movimentation, Vector2.UP)


func gravity(_movimentation):
	var movimentation = _movimentation
	movimentation.y += gravity 
	return movimentation

func setAnimations(_movimentation):
	if _movimentation.x > 0.0:
		animatedSprite.play("right")
	
	if _movimentation.x < 0.0:
		animatedSprite.play("left")
	
	if _movimentation == Vector2(0,0):
		animatedSprite.play("default")


func get_movimentation(_movimentation):
	var direction = Vector2(get_x_direction(),get_y_direction()).normalized()
	var movimentation: Vector2 = _movimentation
	if direction != Vector2.ZERO:
		if direction.x != 0:
			movimentation.x = velocity.x * direction.x
		if direction.y != 0:
			#movimentation.y = velocity.y * direction.y * -1
			movimentation.y = velocity.y * direction.y
	else:
		#movimentation.x = move_toward(movimentation.y, 0 , friction)
		movimentation = movimentation.move_toward(Vector2.ZERO , friction)
	return movimentation


func get_x_direction():
	return float(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"))


func get_y_direction():
	return float(Input.get_action_strength("move_down") - Input.get_action_strength("move_up"))	
	#if is_on_floor():
	#	return Input.get_action_strength("move_up")	
	#return 0



