extends KinematicBody2D
class_name Caracter


export var gravity:float = 35;
export var speed:Vector2 = Vector2(600, 1300);

var FLOOR_NORMAL:Vector2 = Vector2.UP
var _velocity:Vector2 = Vector2.ZERO;


func _physics_process(delta):
	_velocity.y += gravity ;
