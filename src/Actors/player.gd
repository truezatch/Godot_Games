extends Actor
# (_) underscore here means it is private

export var stomp_impulse: = 1000.0

func _on_EnemyDetector_area_entered(area: Area2D) -> void:
	_Velocity = calculate_stomp_velocity(_Velocity , stomp_impulse)

func _on_EnemyDetector_body_entered(body: PhysicsBody2D) -> void:
	die()

func _physics_process(delta: float) -> void:
	#return 1 if the key is pressed and 0 if isnt .
	
	#this will check if the jump key is released and the jump streanth depends on on long the key 
	#ispressed . and velocity.y check if the player is in air , will return ture or false depending on that
	var is_jump_iterrupted: = Input.is_action_just_released("jump") and _Velocity.y < 0.0
	var direction = get_direction()
	_Velocity = calculate_move_velocity(_Velocity , direction , Speed , is_jump_iterrupted)
	_Velocity = move_and_slide(_Velocity , FLOOR_NORMAL) 
	#floor normal here it tells the move and slide function where is away from floor(UP)

func get_direction() -> Vector2:
	return Vector2(
	Input.get_action_strength("move_right") - Input.get_action_strength("move_left") , 
	-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)
	
func calculate_move_velocity(linear_velocity: Vector2 , direction: Vector2 ,
							 speed: Vector2 , is_jump_interrupted: bool) -> Vector2:
	
	var new_velocity = linear_velocity
	#new_velocity.x will hold the speed and the directionof the player while in jump state
	new_velocity.x = speed.x * direction.x
	#new_velocity.y will have the gravity and delta(physics process time)
	new_velocity.y += Gravity * get_physics_process_delta_time()
	#if the player has jumped make jump velocity the jump speed * direction
	if direction.y == -1.0:
		new_velocity.y = speed.y * direction.y
	if is_jump_interrupted:
		new_velocity.y = 0.0
	return new_velocity

func calculate_stomp_velocity(linear_velocity: Vector2 , impulse: float) -> Vector2:
	var new_velocity: = linear_velocity
	new_velocity.y = -impulse
	return new_velocity

func die() -> void:
	queue_free()
	PlayerData.deaths += 1
