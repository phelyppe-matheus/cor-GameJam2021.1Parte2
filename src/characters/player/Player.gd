extends Caracter

func _physics_process(delta):
	_velocity = calculate_linear_velocity()
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("move_up") and is_on_floor() else 0.0
	).normalized()


func calculate_linear_velocity():
	var direction:Vector2 = get_direction()
	var new:Vector2 = _velocity
	new.y += gravity 
	if is_on_floor() or direction.x:
		new.x = speed.x * direction.x

	if (direction.y):
		new.y = speed.y * -1

	return new
