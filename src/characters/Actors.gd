extends KinematicBody2D

export var gravity = Vector2(0, 10);
export var velocity = Vector2(0, 100);
export var jump = Vector2(0, 200);

var _current_velocity = Vector2(0, 0);
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
