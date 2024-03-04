extends CharacterBody2D

@export var Min_Dinstance : float =  400
@onready var health_component : HealthComponent = $HealthComponent
@onready var detect_area : Area2D  = $%DetectArea2D
@onready var health_bar = $HealthBar

func _ready():
	detect_area.body_entered.connect(on_body_entered)
	health_component.health_changed.connect(on_health_changed)
	update_health_display()
	

func on_body_entered(body : Node):
	increase_raven_spawn()

func increase_raven_spawn():
	GameEvents.increase_raven_spawn.emit()
	
func update_health_display():
	health_bar.value = health_component.get_health_percent()

func on_health_changed():
	update_health_display()