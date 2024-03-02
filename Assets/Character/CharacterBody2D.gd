extends CharacterBody2D

const SPEED = 300.0


func _process(delta):
	# Define Movement
	var movement_vector = get_movement_vector()
	#Normalize 
	var direction = movement_vector.normalized()
	velocity = direction * SPEED
	move_and_slide()
#Get Input in a Vector2 return
func get_movement_vector():
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(x_movement, y_movement)
