extends Area2D

onready var sprite = $Sprite
onready var collisionShape2d = $CollisionShape2D

func _on_PincelFalso_body_entered(body):
	if body.name == "GhostIntro":
		sprite.visible = false
		collisionShape2d.disabled = true
		body.get_pincel()
