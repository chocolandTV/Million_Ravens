extends Node

@export var enemyPool: Array[PackedScene]
@export var Min_Dinstance : float =  400
@onready var timer : Timer = $Timer
var waittime : float = 0.095
func _ready():
	$Timer.timeout.connect(on_timer_timeout)
	GameEvents.increase_raven_spawn.connect(increase_raven_spawn)

func increase_raven_spawn():
	waittime = min(0.01,waittime - 0.01)
	timer.wait_time  =  waittime
	print("EggEvent: decrased time to : " + str(waittime))
func increase_dificult_over_time():
	waittime = min(0.01,waittime - 0.01)
	timer.wait_time  =  waittime
	print("TimeEvent: decrased time to : " + str(waittime))
func on_timer_timeout():
	if get_parent().isGameStatePaused():
		return
	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		return

	var random_direction = Vector2.RIGHT.rotated(randf_range(0,TAU))
	var spawn_position = player.global_position + (random_direction * Min_Dinstance)
	var rand_index:int = randi() % enemyPool.size()
	var enemy = enemyPool[rand_index].instantiate() as Node2D
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")

	entities_layer.add_child(enemy)
	enemy.global_position = spawn_position