extends StaticBody2D

@export var init_text: String = "test"

func _ready():
      $Label.text = init_text