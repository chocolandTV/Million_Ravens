extends Node

@export var _Enemy_01_Scene: PackedScene
@export var Min_Dinstance : float =  400

func _ready():
	$Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		return

	var random_direction = Vector2.RIGHT.rotated(randf_range(0,TAU))
	var spawn_position = player.global_position + (random_direction * Min_Dinstance)

	var enemy = _Enemy_01_Scene.instantiate() as Node2D
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	
	entities_layer.add_child(enemy)
	enemy.global_position = spawn_position