extends Node
@export var isEnabled : bool = true
@export var START_WAITTIME : float = 0.5
@export var enemyPool: Array[Enemy_Spawn_Weight]

@export var amanager : arena_time_manager
@onready var timer : Timer = $Timer

const MIN_DISTANCE : float =  1200
const SEC_TIME_BETWEEN_WAVES : float = 3000
# ENEMY WAVE MULTIPLIER
const BASE_DAMAGE_MULTIPLIER : float = 0.05
const BASE_SPEED_MULTIPLIER : float  = 0.02
const BASE_HEALTH_MULTIPLIER : float = 0.05
var waittime : float = 0.5
var isPlayerHiding : bool = false
var spawnPool : Array[Node2D]
var current_wave :int = 1
var time_running
# ENEMY MODIFIER
var enemy_damage_bonus :int = 1
var enemy_speed_bonus :int = 1
var enemy_health_bonus :int = 1
#Enemy weight variable
var allWeights :int = 0
func _ready():
	timer.timeout.connect(on_timer_timeout)
	if START_WAITTIME != waittime:
		waittime = START_WAITTIME
	timer.wait_time = waittime
	GameEvents.increase_raven_spawn.connect(increase_raven_spawn)
	GameEvents.playerIsHiding.connect(change_player_isHiding)
	#enemy weight pool# get max weight
	for x in enemyPool:
		allWeights+= x.enemy_weight

func change_player_isHiding(value :bool):
	isPlayerHiding = value
func resetAll():
	waittime = START_WAITTIME
	current_wave = 1
func increase_raven_spawn():
	waittime = max(0.01,waittime - 0.01)
	timer.wait_time  =  waittime
	
func increase_wave():
	# if current_wave == spawnPool.size():
	# 	return
	current_wave += 1
	print("current_wave:", current_wave)
	enemy_damage_bonus = min(int(current_wave*BASE_DAMAGE_MULTIPLIER),1)
	enemy_speed_bonus = min(int(current_wave*BASE_SPEED_MULTIPLIER),1)
	enemy_health_bonus = min(int(current_wave*BASE_HEALTH_MULTIPLIER),1)

	increase_raven_spawn()

func on_timer_timeout():
	if !isEnabled:
		return
	if get_parent().isGameStatePaused():
		return
	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		return
	if isPlayerHiding:
		return
	checkWave()

	for i in range(0,current_wave):	
		spawnEnemy(player.global_position + (Vector2.RIGHT.rotated(randf_range(0,TAU)) * MIN_DISTANCE))

func checkWave():
	# print (amanager.get_delta_time())
	if amanager.get_delta_time() > current_wave * SEC_TIME_BETWEEN_WAVES:
		increase_wave()

func playerHides(value : bool):
	for x in spawnPool:
		if isPlayerHiding:
			x.queue_free()

func spawnEnemy(pos : Vector2):

	var enemy = pick_random_enemy().instantiate() as Node2D
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")

	entities_layer.add_child(enemy)
	enemy.global_position = pos
	# APPLY WAVE MODIFIER ON EACH ENEMY + COULD CHANGE VARIABLES WITH SOME FLOAT 0-1* 
	enemy.apply_bonus(enemy_damage_bonus, enemy_speed_bonus, enemy_health_bonus)

	spawnPool.append(enemy)

func pick_random_enemy():
	var random :int = randi_range(1, allWeights)
	for x in enemyPool:
		allWeights += x.enemy_weight
		if random <= allWeights:
			print (x.enemy_type)
			return x.enemy_weight