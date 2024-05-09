extends CharacterBody2D

class_name Enemy02_FireStarter

@onready var health_component : HealthComponent = $HealthComponent
@onready var hit_box : Area2D = $HitboxComponent
@onready var anim : AnimationPlayer = $AnimationPlayer
@onready var animated_sprite : AnimatedSprite2D = $%AnimatedSprite2D
@onready var timer : Timer = $Timer
@onready var attackTimer :Timer = $AttackTimer
@onready var health_bar = $HealthBar
@onready var player_node = get_tree().get_first_node_in_group("player") as Node2D
const flying_speed : float  = 1500.0
const walking_speed: float = 100
var current_speed: float =100
var speed_bonus : float = 0
const damage :float = 1000

var target_pos : Vector2 = Vector2.ZERO
var isAttacking : bool = false
var isdashing : bool  =false
func _ready():
      
      animated_sprite.set_animation("Idle")
      health_component.health_changed.connect(on_health_changed)
      update_health_display()
      timer.timeout.connect(on_timer_timeouti)
      attackTimer.timeout.connect(on_timer_timeout_attackTimer)

func _process(_delta):
      #start attack
      start_attack()
      #start flying
      var direction = get_direction_to_target()
      velocity = direction * (current_speed + speed_bonus)
      move_and_slide()

func get_direction_to_target():
      if target_pos != Vector2.ZERO:
            return (target_pos - global_position).normalized()
      #return if not null
      return Vector2.ZERO
func get_target_pos():
      if player_node != null:
            return player_node.global_position
      return Vector2.ZERO

func start_attack():
      if isAttacking && !isdashing:
            target_pos = get_target_pos()

      if (Vector2((target_pos- global_position).normalized().x,1)) == Vector2(-1,1):
            animated_sprite.flip_h = false
      else:
            animated_sprite.flip_h = true
      if !isAttacking:
            isAttacking = true
            attackTimer.start()
            isdashing = true
            current_speed = flying_speed
            animated_sprite.set_animation("flying")
func on_raven_reached_target_position():
      isdashing =false
      $CPUParticles2D.emitting = true
      $Tear_Sprite2D.visible = true
      timer.start()
      animated_sprite.set_animation("Idle")
      anim.play("Raven_walking")
      current_speed = walking_speed

func on_timer_timeouti():
      $Tear_Sprite2D.visible = false
      isAttacking = false
      animated_sprite.set_animation("start")
      anim.stop()

func update_health_display():
      health_bar.value = health_component.get_health_percent()

func on_health_changed():
      update_health_display()

func on_timer_timeout_attackTimer():
      on_raven_reached_target_position()

func apply_bonus(enemy_damage_bonus : int, enemy_speed_bonus: int, enemy_health_bonus: int):
      speed_bonus += (enemy_speed_bonus)
      $HitboxComponent.apply_damage_bonus(damage + (enemy_damage_bonus))
      $HealthComponent.apply_health_bonus(enemy_health_bonus)
