extends Area2D



func _on_Area2D_body_entered(body):
	get_paint_brush()

func get_paint_brush():
	$"paintbrush normal".visible = false
	$CollisionShape2D.disabled = true
