extends CharacterBody2D


@export var _Enemy_01_Scene: PackedScene
@export var Min_Dinstance : float =  400
@onready var health_component : HealthComponent = $HealthComponent
@onready var detect_area : Area2D  = $%DetectArea2D
@onready var health_bar = $HealthBar

func _ready():
	detect_area.body_entered.connect(on_body_entered)
	health_component.health_changed.connect(on_health_changed)
	update_health_display()

func on_body_entered(body : Node):
	
	if !body.is_in_group("player"):
		return
	for i in health_component.current_health:
		var enemy = _Enemy_01_Scene.instantiate() as Node2D
		var entities_layer = get_tree().get_first_node_in_group("entities_layer")

		entities_layer.add_child(enemy)
		enemy.global_position = global_position

func update_health_display():
	health_bar.value = health_component.get_health_percent()

func on_health_changed():
	update_health_display()