extends KinematicBody2D
class_name Actor

export var gravity := 300;
export var speed := Vector2(300, 1000);
export var jump := Vector2(0, 200);

var _velocity = Vector2.ZERO;
#func _ready():
#	pass # Replace with function body.

func _physics_process(delta):
	_velocity.y += gravity * delta;
	_velocity = move_and_slide(_velocity)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
