extends Panel

@onready var health_icon : TextureRect  =$Health_icon

func _ready(): 
      setstatus(true)

func setstatus(value:bool):
      health_icon.visible = value