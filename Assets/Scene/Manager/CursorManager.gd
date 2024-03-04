extends Area2D

@export var upgrades : UpgradeManager
@export var player : CharacterBody2D

var cursor_base = load("res://Assets/Textures/cursor_base.png")
var cursor_to_far = load("res://Assets/Textures/cursor_to_far.png")

var camera_node

func _ready():
	camera_node = get_tree().get_first_node_in_group("camera") as Camera2D
# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
# 	var distance_a  =Vector2(camera_node.get_local_mouse_position() + camera_node.global_position).distance(player.global_position)
# 	if( distance_a > (upgrades.current_upgrades["attack_range"].quantity*5)+450):
	