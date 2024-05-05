extends StaticBody2D

func _ready():
      $HealthComponent.health_changed.connect(on_health_changed)


func on_health_changed():
      $CPUParticles2D.emit()
      $AnimationPlayer.play("Kaktus")
      $HealthBar.value =$HealthComponent.get_health_percent()