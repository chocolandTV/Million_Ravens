extends Sprite2D

var hearth_100p:Texture2D= load("res://Assets/Textures/UI/health/hearth_100p.png")
var hearth_90p :Texture2D= load("res://Assets/Textures/UI/health/hearth_90p.png")
var hearth_80p :Texture2D= load("res://Assets/Textures/UI/health/hearth_80p.png")
var hearth_70p :Texture2D= load("res://Assets/Textures/UI/health/hearth_70p.png")
var hearth_60p :Texture2D= load("res://Assets/Textures/UI/health/hearth_60p.png")
var hearth_50p :Texture2D= load("res://Assets/Textures/UI/health/hearth_50p.png")
var hearth_40p :Texture2D= load("res://Assets/Textures/UI/health/hearth_40p.png")
var hearth_30p :Texture2D= load("res://Assets/Textures/UI/health/hearth_30p.png")
var hearth_20p :Texture2D= load("res://Assets/Textures/UI/health/hearth_20p.png")
var hearth_10p :Texture2D= load("res://Assets/Textures/UI/health/hearth_10p.png")
var hearth_00p :Texture2D= load("res://Assets/Textures/UI/health/hearth_00p.png")
func _ready():
      update_bigLife(1000)

func update_bigLife(value : int):
      texture = get_life_texture(value)
func get_life_texture(_value):
      if _value == 1000:
            return hearth_100p
      if _value >900:
            return hearth_90p
      if _value >800:
            return hearth_80p
      if _value >700:
            return hearth_70p
      if _value >600:
            return hearth_60p
      if _value >500:
            return hearth_50p
      if _value >400:
            return hearth_40p
      if _value >300:
            return hearth_30p
      if _value >200:
            return hearth_20p
      if _value >100:
            return hearth_10p
      if _value == 0:
            return hearth_100p
      