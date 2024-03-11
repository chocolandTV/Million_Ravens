extends CharacterBody2D

const SPEED = 150.0
const DASH_SPEED = 1500.0
const ACCELERATION_SMOOTHING = 25

func _process(delta):
	
	# Define Movement
	var movement_vector = get_movement_vector()
	#Normalize 
	var direction = movement_vector.normalized()
	var target_velocity = direction * SPEED
	velocity = velocity.lerp(target_velocity, 1 - exp(-delta * ACCELERATION_SMOOTHING))
	move_and_slide()
#Get Input in a Vector2 return
func get_movement_vector():
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(x_movement, y_movement)

func player_dash():
	var movement_vector = get_movement_vector()
	var direction = movement_vector.normalized()
	var target_velocity = direction * DASH_SPEED
	velocity += target_velocity
	move_and_slide()