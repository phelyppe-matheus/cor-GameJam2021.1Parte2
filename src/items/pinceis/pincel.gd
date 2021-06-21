extends Area2D

onready var anim_player: AnimationPlayer = $AnimationPlayer

export var next_scene: PackedScene


func _on_body_entered(body):
	teleport()

func _get_configuration_warning():
	return "" if next_scene else 'The next scene can\'t be empty'

func teleport():
	$sprite.visible = false
	anim_player.play("FADE_IN")
	yield(anim_player, "animation_finished")
	get_tree().change_scene_to(next_scene)
