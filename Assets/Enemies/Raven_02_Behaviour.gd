extends CharacterBody2D

class_name Enemy02_FireStarter

@onready var health_component : HealthComponent = $HealthComponent
@onready var hit_box : Area2D = $HitboxComponent
@onready var anim : AnimationPlayer = $AnimationPlayer
@onready var animated_sprite : AnimatedSprite2D = $%AnimatedSprite2D
@onready var timer : Timer = $Timer
@onready var attackTimer :Timer = $AttackTimer
@onready var health_bar = $HealthBar

const speed : float  = 1000.0
const damage :int  = 100
var isCooldown : bool  = false
var isPlayerInVision :bool = false
var target_pos : Vector2 = Vector2.ZERO
var isAttacking : bool = false
func _ready():
      hit_box.damage = damage
      animated_sprite.set_animation("Idle")
      health_component.health_changed.connect(on_health_changed)
      update_health_display()
      timer.timeout.connect(on_timer_timeouti)
      attackTimer.timeout.connect(on_timer_timeout_attackTimer)

func _process(_delta):
      if isCooldown:
            return
      if !isPlayerInVision:
            return
      #get direction
      var direction = get_direction_to_target()
      #start flying
      velocity = direction * speed
      move_and_slide()

func get_direction_to_target():
      if target_pos != Vector2.ZERO:
            return (target_pos - global_position).normalized()
      #return if not null
      return Vector2.ZERO
func get_target_pos():
      var player_node = get_tree().get_first_node_in_group("player") as Node2D
      if player_node != null:
            return player_node.global_position
      return Vector2.ZERO

func on_area_entered_player(_area :Area2D):
      if !isAttacking:
            isAttacking = true
            attackTimer.start()
            target_pos = get_target_pos()
            isPlayerInVision = true
            animated_sprite.set_animation("start")
func on_raven_reached_target_position():
      # got pos and activate Cooldown
      print("got pos and activate Cooldown")
      isPlayerInVision = false
      isCooldown = true
      timer.start()
      animated_sprite.set_animation("Idle")

func on_timer_timeouti():
      isCooldown = false
      isAttacking = false


func _on_vision_radius_area_exited(_area:Area2D):
      isPlayerInVision = false

func update_health_display():
      health_bar.value = health_component.get_health_percent()

func on_health_changed():
      update_health_display()

func on_timer_timeout_attackTimer():
      on_raven_reached_target_position()