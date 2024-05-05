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

var player_max_life : float = 3000

func _ready():
      update_bigLife(3000)

func update_newlife(value: int):
      player_max_life +=1000
      update_bigLife(value)

func update_bigLife(value : int):
      var _value = value / player_max_life
      texture = get_life_texture(_value)

func get_life_texture(_value):
      if _value == 1:
            return hearth_100p
      if _value >0.9:
            return hearth_90p
      if _value >0.8:
            return hearth_80p
      if _value >0.7:
            return hearth_70p
      if _value >0.6:
            return hearth_60p
      if _value >0.5:
            return hearth_50p
      if _value >0.4:
            return hearth_40p
      if _value >0.3:
            return hearth_30p
      if _value >0.2:
            return hearth_20p
      if _value >0.1:
            return hearth_10p
      if _value == 0:
            return hearth_00p
      