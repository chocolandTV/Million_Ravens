extends CanvasLayer

@onready var anim_player :AnimationPlayer =$AnimationPlayer
func _ready():
      GameEvents.player_damaged.connect(on_player_damaged)


func on_player_damaged():
      vignette_effect()

func vignette_effect():
      anim_player.play("hit")