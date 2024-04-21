extends TextureRect
@onready var event_timer : Timer  = $Timer
@onready var effect_Timer : Timer =$effect_Timer
func _ready():
      event_timer.timeout.connect(on_timer_timeout)
      effect_Timer.timeout.connect(on_image_effect_timeout)


func on_timer_timeout():
      imageEffect()
      event_timer.start()


func imageEffect():
      # print("imageEffect")
      # SOUND EFFECT
      material.set_shader_parameter("shader_param/bright_amount", 0.75)
      material.set_shader_parameter("shader_param/bright_amount", 0.45)
      material.set_shader_parameter("shader_param/bright_amount", 0.35)
      effect_Timer.start()

func on_image_effect_timeout():
      material.set_shader_parameter("shader_param/bright_amount",0)
