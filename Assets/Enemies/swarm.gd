extends Node2D
class_name Swarm
@onready var timer : Timer = $Timer
@onready var cpuParticles: CPUParticles2D = $%CPUParticles2D
@onready var collision : CollisionShape2D = $%collision_Radius
@onready var enemy : CharacterBody2D = $%Enemy
var isActivated : bool = false
const LEVEL_MULTIPLIER : float  =0.1
var ravi_amount : float  = 200
var swarm_time : float  = 6
var cooldown_time: float = 12
## HANDLE SWARM MODE ON OFF
## HANDLE LEVEL UP - INCREASE SWARM RADIUS AND AMOUNT

func _ready():
	isActivated = false
	timer.timeout.connect(on_timer_timeout)

func on_timer_timeout():
	# CHANGE SWARM STATE
	isActivated = !isActivated
	if isActivated:
		timer.wait_time = swarm_time
		swarmLevelUp()
		print("Swarm activated for %d seconds"%swarm_time)
	else:
		timer.wait_time = cooldown_time
		print("Cooldown activated for %d seconds"%cooldown_time)
	enemy.visible  = isActivated
	timer.start()

func swarmLevelUp():
	#levelup Cooldown Time
	cooldown_time = max(10, cooldown_time * LEVEL_MULTIPLIER)
	#levelup Swarm Time
	swarm_time = min(600, swarm_time + (swarm_time * LEVEL_MULTIPLIER))
	#Particle increase
	ravi_amount += ravi_amount * LEVEL_MULTIPLIER
	cpuParticles.amount =int(ravi_amount)
	#Hitbox Radius increase
	collision.shape.radius += collision.shape.radius *LEVEL_MULTIPLIER