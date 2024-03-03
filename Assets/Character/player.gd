extends CharacterBody2D

const SPEED = 150.0
const ACCELERATION_SMOOTHING = 25
@onready var damage_interval_timer = $DamageIntervalTimer
@onready var player_health_component= $PlayerHealthComponent
var number_colliding_bodies = 0

func _ready():
	$CollisionArea2D.body_entered.connect(on_body_entered)
	$CollisionArea2D.body_exited.connect(on_body_exited)
	damage_interval_timer.timeout.connect(on_damage_interval_timer_timeout)

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

func check_deal_damage():
	if number_colliding_bodies == 0 || !damage_interval_timer.is_stopped():
		return
	player_health_component.damage(1)
	damage_interval_timer.start()
	print(player_health_component.current_health)

func on_body_entered(other_body : Node2D):
	number_colliding_bodies += 1
	check_deal_damage()

func on_body_exited(other_body: Node2D):
	number_colliding_bodies -= 1

func on_damage_interval_timer_timeout():
	check_deal_damage()