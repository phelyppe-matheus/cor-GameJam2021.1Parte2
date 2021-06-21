extends Area2D

onready var close = $fechado
onready var open = $aberto
onready var collisionShape = $collisionShape


var is_hability = false

func on_ready():
	open.visible = true
	close.visible = true
	collisionShape.disabled = false

func next_level():
	print("saindo") # Replace with function body.
	
	

func _on_portal_body_entered(body):
	if is_hability and body.name == 'Ghost': 
		next_level()

func _on_portal_area_shape_entered(area_id, area, area_shape, local_shape):
	print(area.name)
	if !is_hability:
		is_hability = true
		close.visible = false
		print("abrindo")
	
	



