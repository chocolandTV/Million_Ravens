extends CharacterBody2D

class_name Enemy01_Ravii

@onready var health_component : HealthComponent = $HealthComponent
@onready var hit_box : Area2D = $%HitboxComponent
@onready var anim : AnimationPlayer = $%AnimationPlayer

@export var speed :float  =325.0
@export var damage =5 
signal raven_01_kockback

func _ready():
      hit_box.damage = damage
      raven_01_kockback.connect(on_raven_01_knockback)
func _process(_delta):
      #get direction
      var direction = get_direction_to_player()
      #start flying
      velocity = direction * speed
      move_and_slide()
      # increase speed

func get_direction_to_player():
      #get player
      var player_node = get_tree().get_first_node_in_group("player") as Node2D
      if player_node != null:
            return (player_node.global_position - global_position).normalized()
      #return if not null
      return Vector2.ZERO
func on_raven_01_knockback():
      print("knockback effect")
      #animate 
      anim.play("Knockback")

      #set position in back in direction of player * damage
      global_position += -get_direction_to_player() * damage * 10