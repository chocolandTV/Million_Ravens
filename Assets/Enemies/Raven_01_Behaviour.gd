extends CharacterBody2D

class_name Enemy01_Ravii

@onready var health_component : HealthComponent = $HealthComponent
# @onready var hit_box : Area2D = $HitboxComponent
@onready var anim : AnimationPlayer = $AnimationPlayer
@onready var timer : Timer = $Timer

const speed : float  = 325.0
const damage :int  = 1 
var isCooldown : bool  = false

func _ready():
      # hit_box.damage = damage
      # hit_box.raven_01_kockback.connect(on_raven_01_knockback)
      timer.timeout.connect(on_timer_timeouti)
func _process(_delta):
      if isCooldown:
            return
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
      #animate 
      anim.play("Knockback")
      #set position in back in direction of player * damage
      global_position += -get_direction_to_player() * damage * 10
      isCooldown = true
      timer.start()

func on_timer_timeouti():
      isCooldown = false
