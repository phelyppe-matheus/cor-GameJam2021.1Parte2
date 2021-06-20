extends Actor
class_name Ghost

export var velocity = Vector2(600, 600)
var friction = 100
var _wind = 0

var _movimentation = Vector2(0,0)
var player_gravity = true
onready var animatedSprite = $AnimatedSprite



func _on_wind_body_entered(body):
	_wind = 1

func _on_wind_body_exited(body):
	_wind = 0


func _physics_process(delta):

	_movimentation = get_movimentation()

	setAnimations()

	if not _wind:
		_movimentation = move_and_slide(_movimentation, Vector2.UP)
	else:
		_wind += calculate_wind()
		_movimentation.x -= _wind
		_movimentation = move_and_slide(_movimentation, Vector2.UP)


func setAnimations():
	if _movimentation.x > 0.0:
		animatedSprite.play("right")

	if _movimentation.x < 0.0:
		animatedSprite.play("left")

	if _movimentation.x == 0.0:
		animatedSprite.play("default")


func calculate_linear_velocity():
	var direction:Vector2 = get_direction()
	var new:Vector2 = _velocity
	new.y += gravity * get_physics_process_delta_time()
	if is_on_floor() or direction.x:
		new.x = speed.x * direction.x

	if (direction.y):
		new.y = speed.y * -1

	return new


func get_movimentation():
	var direction = get_direction()
	var movimentation: Vector2 = _movimentation
	movimentation.y = 0 if is_on_floor() else gravity

	movimentation.x = speed.x * direction.x if direction.x else 0

	movimentation.y = speed.y * direction.y if direction.y else movimentation.y
	return movimentation


func get_direction():
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)


func calculate_wind():
	return 30 if _wind < 700 else 700
