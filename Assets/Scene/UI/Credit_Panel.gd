extends MarginContainer
@onready var label : Label =$Panel/Label
var funCounter :int = 2
const max_int = 9223372036854775807 # Biggest value an int can store
func resetName():
      label.text = "Robert Mögenburg"
      funCounter = 2

func _on_enter_button():
      SoundManager.Emit_Sound(SoundManager.soundType.s_ui_click,Vector2.ZERO)
      if funCounter >= max_int || funCounter <=0:
            label.text ="You Won - Max Int"
            funCounter = 2
      else:
            funCounter += funCounter
            label.text  = str(funCounter)