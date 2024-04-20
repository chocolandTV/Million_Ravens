extends Node
@export var isEnabled : bool = true
@export var START_WAITTIME : float = 0.5
@export var enemyPool: Array[PackedScene]
@export var amanager : arena_time_manager
@onready var timer : Timer = $Timer

const MIN_DISTANCE : float =  1200
var waittime : float = 0.5
var isPlayerHiding : bool = false
var spawnPool : Array[Node2D]
var current_wave :int = 0
var time_running
func _ready():
	timer.timeout.connect(on_timer_timeout)
	if START_WAITTIME != waittime:
		waittime = START_WAITTIME
	timer.wait_time = waittime
	GameEvents.increase_raven_spawn.connect(increase_raven_spawn)
	GameEvents.playerIsHiding.connect(change_player_isHiding)

func change_player_isHiding(value :bool):
	isPlayerHiding = value
func resetAll():
	waittime = START_WAITTIME
	current_wave = 0
func increase_raven_spawn():
	waittime = max(0.01,waittime - 0.01)
	timer.wait_time  =  waittime
	print("Wave: decrased time to : " + str(waittime))
func increase_wave():
	if current_wave == spawnPool.size():
		return
	current_wave += 1
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
	spawnEnemy(player.global_position + (Vector2.RIGHT.rotated(randf_range(0,TAU)) * MIN_DISTANCE))

func checkWave():
	if amanager.get_delta_time() > current_wave * 6000:
		increase_wave()
func playerHides(value : bool):
	for x in spawnPool:
		if isPlayerHiding:
			x.queue_free()

func spawnEnemy(pos : Vector2):
	# print (current_wave)
	var enemy = enemyPool[current_wave].instantiate() as Node2D
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")

	entities_layer.add_child(enemy)
	enemy.global_position = pos
	spawnPool.append(enemy)