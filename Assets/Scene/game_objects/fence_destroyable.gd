extends StaticBody2D

@onready var health_component : HealthComponent = $HealthComponent
@onready var player_animations : AnimatedSprite2D = $AnimatedSprite2D

@onready var animationPlayer : AnimationPlayer = $AnimationPlayer

@onready var health_bar = $HealthBar
func _ready():
      health_component.died.connect(on_fence_died)
      health_component.health_changed.connect(on_fence_damaged)
      health_bar.value = health_component.get_health_percent()

func on_fence_died(_type: int):
      # player_animations.animation="dying"
      animationPlayer.play("died")
func on_fence_damaged():
      if !health_bar.is_visible_in_tree():
            health_bar.visible = true
      animationPlayer.play("damaged")
      $CPUParticles2D.emitting = true
      health_bar.value = health_component.get_health_percent()
