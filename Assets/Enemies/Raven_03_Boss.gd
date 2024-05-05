extends CharacterBody2D
@export var damage = 1000

@onready var health_component : HealthComponent = $HealthComponent
const speed : float  = 145.0

@onready var health_bar = $HealthBar
@onready var player_node = get_tree().get_first_node_in_group("player") as Node2D

func _ready():
	health_component.health_changed.connect(on_health_changed)
	update_health_display()
func _process(_delta):
      #get direction
	var direction = get_direction_to_player()
      #start flying
	velocity = direction * speed
	move_and_slide()
      # increase speed
func update_health_display():
	health_bar.value = health_component.get_health_percent()

func on_health_changed():
	update_health_display()

func get_direction_to_player():
	#get player
	if player_node != null:
		return (player_node.global_position - global_position).normalized()
      #return if not null
	return Vector2.ZERO

