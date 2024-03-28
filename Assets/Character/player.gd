extends CharacterBody2D
@onready var globalVars : Global_Variables = get_node("/root/GlobalVariables")
@onready var invincible_timer:Timer = $InvincibleTimer
@onready var hurtboxComponent:Area2D = $HurtboxComponent
const SPEED = 150.0
const DASH_SPEED = 1500.0
const ACCELERATION_SMOOTHING = 25
var speed_multiplier : float = 1

func _ready():
	invincible_timer.timeout.connect(on_invincible_timeout)
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)
func _process(delta):
	# Define Movement
	var movement_vector = get_movement_vector()
	#Normalize 
	var direction = movement_vector.normalized()
	var target_velocity = direction * SPEED * speed_multiplier
	velocity = velocity.lerp(target_velocity, 1 - exp(-delta * ACCELERATION_SMOOTHING))
	move_and_slide()
#Get Input in a Vector2 return
func get_movement_vector():
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(x_movement, y_movement)

func player_dash():
	hurtboxComponent.monitoring = false
	invincible_timer.start()
	var movement_vector = get_movement_vector()
	var direction = movement_vector.normalized()
	var target_velocity = direction * DASH_SPEED * speed_multiplier
	velocity += target_velocity
	move_and_slide()

func on_invincible_timeout():
	hurtboxComponent.monitoring = true


func on_ability_upgrade_added(upgrade : AbilityUpgrade, current_upgrades: Dictionary):
	if upgrade.id == "player_movement_speed":
		speed_multiplier  += 0.1 * (current_upgrades[upgrade.id]["quantity"])
		globalVars.gv_Settings[ "player_movement_speed_level"]  =(current_upgrades[upgrade.id]["quantity"])
