extends Area2D
# This demo is an example of controling a high number of 2D objects with logic
# and collision without using nodes in the scene. This technique is a lot more
# efficient than using instancing and nodes, but requires more programming and
# is less visual. Bullets are managed together in the `grains.gd` script.

const GRAIN_COUNT = 100
const SPEED_MIN = 400
const SPEED_MAX = 800

const grain_image = preload("res://assets/desert/sand/grain.png")

var grains = []
var shape


class Grain:
	var position = Vector2()
	var speed = 1.0
	# The body is stored as a RID, which is an "opaque" way to access resources.
	# With large amounts of objects (thousands or more), it can be significantly
	# faster to use RIDs compared to a high-level approach.
	var body = RID()


func _ready():
	randomize()

	shape = Physics2DServer.circle_shape_create()
	# Set the collision shape's radius for each grain in pixels.
	Physics2DServer.shape_set_data(shape, 8)

	for _i in GRAIN_COUNT:
		var grain = Grain.new()
		# Give each grain its own speed.
		grain.speed = rand_range(SPEED_MIN, SPEED_MAX)
		grain.body = Physics2DServer.body_create()

		Physics2DServer.body_set_space(grain.body, get_world_2d().get_space())
		Physics2DServer.body_add_shape(grain.body, shape)

		# Place grains randomly on the viewport and move grains outside the
		# play area so that they fade in nicely.
		grain.position = Vector2(
			rand_range(0, get_viewport_rect().size.x) + get_viewport_rect().size.x,
			rand_range(0, get_viewport_rect().size.y)
		)
		var transform2d = Transform2D()
		transform2d.origin = grain.position
		Physics2DServer.body_set_state(grain.body, Physics2DServer.BODY_STATE_TRANSFORM, transform2d)

		grains.push_back(grain)


func _process(delta):
	var transform2d = Transform2D()
	for grain in grains:
		grain.position.x -= grain.speed * delta

		if grain.position.x < -16:
			# The grain has left the screen; move it back to the right.
			grain.position.x = get_viewport_rect().size.x + 16

		transform2d.origin = grain.position

		Physics2DServer.body_set_state(grain.body, Physics2DServer.BODY_STATE_TRANSFORM, transform2d)

	# Order the CanvasItem to update since grains are moving every frame.
	update()


# Instead of drawing each grain individually in a script attached to each grain,
# we are drawing *all* the grains at once here.
func _draw():
	var offset = -grain_image.get_size() * 0.5
	for grain in grains:
		draw_texture(grain_image, grain.position + offset)


# Perform cleanup operations (required to exit without error messages in the console).
func _exit_tree():
	for grain in grains:
		Physics2DServer.free_rid(grain.body)

	Physics2DServer.free_rid(shape)
	grains.clear()
