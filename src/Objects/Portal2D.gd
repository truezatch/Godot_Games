tool
extends Area2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer") #can also do $AnimationPlayer
																	  #instead of get_node
export var next_scene : PackedScene

func _on_Portal2D_body_entered(body: PhysicsBody2D) -> void:
	teleport()

func _get_configuration_warning() -> String:
	return "The next scene property cant be empty " if not next_scene else ""

func teleport() -> void:
	anim_player.play("Fade_in")
	#waits basically say wait for the anim_player to finish(finish is defined by animation_finished)
	yield(anim_player , "animation_finished") #animation_finished send a signal to yield that the anim has finished
	get_tree().change_scene_to(next_scene)

