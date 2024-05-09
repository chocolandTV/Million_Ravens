extends Node
@export var isEnabled : bool = true
@export var START_WAITTIME : float = 0.1
@export var enemyPool: Array[PackedScene]
@export var ravenLord_Scene : PackedScene
@export var amanager : arena_time_manager

@onready var timer : Timer = $Timer
@onready var entities_layer = get_tree().get_first_node_in_group("entities_layer")
const MIN_DISTANCE : float =  1200
const SEC_TIME_BETWEEN_WAVES : float = 3000
const SEC_TIMES_WAITTIME_INCREASER : int = 10
# ENEMY WAVE MULTIPLIER
const BASE_DAMAGE_MULTIPLIER : float = 0.05
const BASE_SPEED_MULTIPLIER : float  = 0.02
const BASE_HEALTH_MULTIPLIER : float = 0.05
var waittime : float = 0.5
var waittimer_wave_counter : int = 0
var isPlayerHiding : bool = false
var spawnPool : Array[Node2D]
var current_wave :int = 1

var time_running : float = 0
# ENEMY MODIFIER
var enemy_damage_bonus :int = 1
var enemy_speed_bonus :int = 1
var enemy_health_bonus :int = 1
#Enemy weight variable
var allWeights :int = 0
# Lucky enemy bool
var isLuckyEvent : bool  =false
var _tempWaitTime: float = 0
func _ready():
	timer.timeout.connect(on_timer_timeout)
	if START_WAITTIME != waittime:
		waittime = START_WAITTIME
	timer.wait_time = waittime
	GameEvents.increase_raven_spawn.connect(increase_raven_spawn)
	GameEvents.decrease_raven_spawn.connect(decrease_raven_spawn)
	GameEvents.playerIsHiding.connect(change_player_isHiding)
	GameEvents.midGame_region_raven_cleared.connect(spawnRavenLord)
	GameEvents.lucky_event.connect(on_lucky_Event)
	
func _process(delta):
	time_running += delta

func change_player_isHiding(value :bool):
	isPlayerHiding = value

func resetAll():
	waittime = START_WAITTIME
	current_wave = 1

func increase_raven_spawn():
	waittime = max(0.01,waittime - 0.01)
	timer.wait_time  =  waittime

func decrease_raven_spawn():
	waittime = max(0.01,waittime + 0.01)
	timer.wait_time  =  waittime

func wave_increase_raven_spawner():
	waittimer_wave_counter +=1
	if waittimer_wave_counter >= 10:
		increase_raven_spawn()

func increase_wave():
	current_wave += 1
	print("current_wave:", current_wave)
	enemy_damage_bonus = current_wave
	enemy_speed_bonus = current_wave
	enemy_health_bonus = current_wave
	wave_increase_raven_spawner()

# FUNCTION FOR LUCKY EVENT
func on_lucky_Event(_value : bool):
	isLuckyEvent =_value
	if isLuckyEvent:
		#Start Lucky Event
		print("Lucky_Event: Start")
		_tempWaitTime = waittime
		timer.wait_time = 0.01
	if !isLuckyEvent:
		isLuckyEvent =_value
		timer.wait_time = 0.5
		_tempWaitTime = 0

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
	if time_running > current_wave * SEC_TIME_BETWEEN_WAVES:
		increase_wave()

func playerHides(value : bool):
	for x in spawnPool:
		if isPlayerHiding:
			x.queue_free()

func spawnEnemy( pos : Vector2):
	var enemy = pick_random_enemy().instantiate() as Node2D
	entities_layer.add_child(enemy)
	enemy.global_position = pos
	# APPLY WAVE MODIFIER ON EACH ENEMY + COULD CHANGE VARIABLES WITH SOME FLOAT 0-1* 
	enemy.apply_bonus(enemy_damage_bonus, enemy_speed_bonus, enemy_health_bonus)
	spawnPool.append(enemy)

func spawnRavenLord(pos: Vector2):
	await get_tree().physics_frame
	var _enemy = ravenLord_Scene.instantiate() as CharacterBody2D
	entities_layer.add_child(_enemy)
	_enemy.global_position = pos
	GameEvents.midGame_region_boss_spawned.emit(_enemy.get_node("HealthComponent") as HealthComponent)


func pick_random_enemy():
	if isLuckyEvent:
		return enemyPool[7]
	var random :int = randi_range(1, 100)
	if random == 20:# FIRESTARTER
		return enemyPool[1]

	if random ==30 :# Formation R
		return enemyPool[2]

	if random ==40 :# Formation A
		return enemyPool[3]

	if random ==50 :# Formation V
		return enemyPool[4]

	if random ==60 :# Formation E
		return enemyPool[5]

	if random ==70 :# Formation N
		return enemyPool[6]

	return enemyPool[0]