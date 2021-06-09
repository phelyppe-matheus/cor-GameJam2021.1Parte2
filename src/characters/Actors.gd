extends KinematicBody2D
class_name Actor

export var gravity:float = 500;
export var speed:Vector2 = Vector2(400, 500);

var FLOOR_NORMAL:Vector2 = Vector2.UP
var _velocity:Vector2 = Vector2.ZERO;
#func _ready():
#	pass # Replace with function body.

func _physics_process(delta):
	_velocity.y += gravity * delta;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
