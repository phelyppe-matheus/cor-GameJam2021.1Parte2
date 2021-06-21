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
onready var flying_pass = 0
onready var time_flying = 0
onready var default_time_flying = 10

onready var brushRight = $Brush/BrushRight
onready var brushRightCollision = $Brush/Right
onready var brushLeft = $Brush/BrushLeft
onready var brushLeftCollision = $Brush/Left

onready var has_brush = false
onready var paint_side = 1
onready var paint_time = 0
onready var paint_time_default = 2

func _ready():
	brushRight.visible = false
	brushRightCollision.disabled = true
	brushLeft.visible = false
	brushLeftCollision.disabled = true

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
	var d = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if d > 0:
		paint_side = 1
	else:
		if d < 0:
			paint_side = -1
	return float(d)

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
	check_paint_press()


func check_paint_press():
	if Input.get_action_strength("paint"):
		paint()
	

		
func check_flying_press():
	if !flying:
		if Input.get_action_strength("ui_accept"):
			if flying_pass > 0:
				flying_pass = flying_pass - 1
				flying = true	
				time_flying = default_time_flying

func paint():
	if paint_time <=0 and has_brush:
		paint_time = paint_time_default
		if paint_side == 1:
			brushRight.visible = true
			brushRightCollision.disabled = false
			brushRight.play('right')
		else:
			brushLeft.visible = true
			brushLeftCollision.disabled = false
			brushLeft.play('left')

	
func stop_flying():
	if time_flying == 0:
		flying = false

	
func add_flying_pass():
	flying_pass = flying_pass + 1


func _on_Timer_timeout():
	if time_flying > 0: 
		time_flying = time_flying - 1
		
	if paint_time >= 0: 
		paint_time = paint_time - 1
		
	if paint_time == 0:
		brushRight.stop()
		brushRight.visible = false
		brushLeftCollision.disabled = true
		brushRightCollision.disabled = true
		brushLeft.stop()
		brushLeft.visible = false
	
	
	


func _on_paintBrush_body_entered(body):
	has_brush = true
