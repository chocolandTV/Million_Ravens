extends CharacterBody2D

class_name Enemy08_Lucky

var speed : float  = 1000.0
const MUTATION_CHANCE : float = 0.01
const damage :int  = 1 
var isCooldown : bool  = false
@onready var anim: AnimationPlayer =$AnimationPlayer
@onready var sprite : AnimatedSprite2D =$AnimatedSprite2D
@onready var sprite_Highlighter : Sprite2D = $AnimatedSprite2D/Sprite2D_BG

# damage Type check equals with enemy
var damage_type_enemy : int = 0
var player_node : Node2D
func _ready():
      $Timer.timeout.connect(on_timer_timeouti)
      $HealthComponent.health_damage_knockback.connect(on_raven_01_knockback)
      $HealthComponent.health_changed.connect(on_health_changed)
      player_node = get_tree().get_first_node_in_group("player") as Node2D
      $AnimatedSprite2D.rotation= (player_node.global_position - self.global_position).angle()
      var random_color = Color(randf(), randf(), randf())
      sprite.modulate = random_color
      sprite_Highlighter.modulate = random_color
      anim.play("dancing")


func _process(_delta):
      if isCooldown:
            return
      #get direction
      var direction = get_direction_to_player()
      #start flying
      velocity = direction * speed
      move_and_slide()

func get_direction_to_player():
      #get player
      if player_node != null:
            return (player_node.global_position - global_position).normalized()
      #return if not null
      return Vector2.ZERO

func on_health_changed():
      $HealthBar.visible = true
      $HealthBar.value = $HealthComponent.get_health_percent()

func on_raven_01_knockback():
      $AnimationPlayer.play("Knockback")
      global_position += -get_direction_to_player() * 50
      isCooldown = true
      $Timer.start()

func on_timer_timeouti():
      isCooldown = false

func apply_bonus(_enemy_damage_bonus : int, _enemy_speed_bonus: int, _enemy_health_bonus: int):
      pass
