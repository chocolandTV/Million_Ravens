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
      update_bigLife(0)

func update_bigLife(value : int):
      #ausgabe 0- 999
      match value:
            0:
                  texture = hearth_100p
                  print  ("BigLife 100")
            1-99:
                  texture = hearth_10p
                  print  ("BigLife 10")
            100-199:
                  texture = hearth_20p
                  print  ("BigLife 20")
            200-299:
                  texture = hearth_30p
                  print  ("BigLife 30")
            300-399:
                  texture = hearth_40p
                  print  ("BigLife 40")
            400-499:
                  texture = hearth_50p
                  print  ("BigLife 50")
            500-599:
                  texture = hearth_60p
                  print  ("BigLife 60")
            600-699:
                  texture = hearth_70p
                  print  ("BigLife 70")
            700-799:
                  texture = hearth_80p
                  print  ("BigLife 80")
            800-999:
                  texture = hearth_90p
                  print  ("BigLife 90")
            
