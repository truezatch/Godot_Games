extends "res://src/Actors/Actor.gd"

export var score: = 100

func _ready() -> void:
	set_physics_process(false)
	_Velocity.x = -Speed.x

#the stomp detector will emmit this signal and run its behavior 
func _on_StompDetector_body_entered(body: PhysicsBody2D) -> void:
	#checking if the physicsbody's y pos is lower than stompdetector's ypos
	if body.global_position.y > get_node("VisibilityEnabler2D/StompDetector").global_position.y:
		return #this return will delect this enemy can also use queue_free()
	get_node("VisibilityEnabler2D/StompDetector/CollisionShape2D").disabled = true
	die()

func _physics_process(delta: float) -> void:
	_Velocity.y += Gravity * delta
	if is_on_wall():
		_Velocity.x *= -1.0
	_Velocity.y = move_and_slide(_Velocity , FLOOR_NORMAL).y

func die() -> void:
	queue_free()
	PlayerData.score += score
