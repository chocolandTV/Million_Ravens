extends CharacterBody2D
@export var damage = 1000

@onready var health_component : HealthComponent = $HealthComponent

@onready var health_bar = $HealthBar

func _ready():
	
	health_component.health_changed.connect(on_health_changed)
	update_health_display()

func update_health_display():
	health_bar.value = health_component.get_health_percent()

func on_health_changed():
	update_health_display()