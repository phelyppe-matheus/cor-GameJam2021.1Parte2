extends KinematicBody2D
class_name Ghost

export var gravity = 40
export var velocity = Vector2(600, 800)
export var velocity_flying = Vector2(600, 600)
var friction = 100

var _movimentation = Vector2(0,0)
var player_gravity = true
onready var animatedSprite = $AnimatedSprite

onready var flying = false
onready var flying_pass = 1
onready var time_flying = 0
onready var default_time_flying = 15

func _physics_process(delta):
	
	_movimentation = gravity(_movimentation)
	
	_movimentation = get_movimentation(_movimentation)
	check_actions()
	setAnimations(_movimentation)
	
	_movimentation = move_and_slide(_movimentation, Vector2.UP)


func gravity(_movimentation):
	var movimentation = _movimentation
	if !flying:
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
			if flying:
				movimentation.y = velocity_flying.y * direction.y
			else:
				movimentation.y = velocity.y * direction.y * -1
	else:
		if flying:
			movimentation = movimentation.move_toward(Vector2.ZERO , friction)
		else:
			movimentation.x = move_toward(movimentation.x, 0 , friction)
	return movimentation


func get_x_direction():
	return float(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"))


func get_y_direction():
	if flying:
		return float(Input.get_action_strength("move_down") - Input.get_action_strength("move_up"))	
	else:
		if is_on_floor():
			return float(Input.get_action_strength("move_up"))	
		return 0

func check_actions():
	stop_flying()
	check_flying_press()	
	
func stop_flying():
	if time_flying == 0:
		flying = false

func check_flying_press():
	if Input.get_action_strength("ui_accept"):
		if flying_pass > 0:
			flying_pass = flying_pass - 1
			flying = true	
			time_flying = default_time_flying
	
func add_flying_pass():
	flying_pass = flying_pass + 1

func _on_Timer_timeout():
	if time_flying > 0: 
		time_flying = time_flying - 1
