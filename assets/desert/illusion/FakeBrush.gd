extends Area2D

export var BRUSH_COUNT = 10

const brush_image = preload("res://assets/collection/pincel.png")

var brushs = []
var shape


class FakeBrush:
	var position = Vector2()
	var body = RID()


func _ready():
	randomize()

	shape = Physics2DServer.circle_shape_create()
	# Set the collision shape's radius for each grain in pixels.
	Physics2DServer.shape_set_data(shape, 16)

	for _i in BRUSH_COUNT:
		var brush = FakeBrush.new()
		brush.body = Physics2DServer.body_create()

		Physics2DServer.body_set_space(brush.body, get_world_2d().get_space())
		Physics2DServer.body_add_shape(brush.body, shape)
		brush.position = Vector2(
			rand_range(-get_node("CollisionShape2D").shape.extents.x,
						get_node("CollisionShape2D").shape.extents.x),
			rand_range(-get_node("CollisionShape2D").shape.extents.y,
						get_node("CollisionShape2D").shape.extents.y)
		)
		var transform2d = Transform2D()
		transform2d.origin = brush.position
		Physics2DServer.body_set_state(brush.body, Physics2DServer.BODY_STATE_TRANSFORM, transform2d)

		brushs.push_back(brush)


#func _process(delta):
#	var transform2d = Transform2D()
#	for brush in brushs:
#		brush.position.x -= brush.speed * delta
#
#		if brush.position.x < -16:
#			# The grain has left the screen; move it back to the right.
#			brush.position.x = get_viewport_rect().size.x + 16
#
#		transform2d.origin = grain.position
#
#		Physics2DServer.body_set_state(grain.body, Physics2DServer.BODY_STATE_TRANSFORM, transform2d)

	# Order the CanvasItem to update since grains are moving every frame.
#	update()


# Instead of drawing each grain individually in a script attached to each grain,
# we are drawing *all* the grains at once here.
func _draw():
	var offset = -brush_image.get_size() * 0.5
	for brush in brushs:
		draw_texture(brush_image, brush.position + offset)


# Perform cleanup operations (required to exit without error messages in the console).
func _exit_tree():
	for brush in brushs:
		Physics2DServer.free_rid(brush.body)

	Physics2DServer.free_rid(shape)
	brushs.clear()
