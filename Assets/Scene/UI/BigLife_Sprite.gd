extends Sprite2D

var hearth_100p :CompressedTexture2D= load("res://Assets/Textures/UI/health/hearth_100p.png")
var hearth_90p :CompressedTexture2D= load("res://Assets/Textures/UI/health/hearth_90p.png")
var hearth_80p :CompressedTexture2D= load("res://Assets/Textures/UI/health/hearth_80p.png")
var hearth_70p :CompressedTexture2D= load("res://Assets/Textures/UI/health/hearth_70p.png")
var hearth_60p :CompressedTexture2D= load("res://Assets/Textures/UI/health/hearth_60p.png")
var hearth_50p :CompressedTexture2D= load("res://Assets/Textures/UI/health/hearth_50p.png")
var hearth_40p :CompressedTexture2D= load("res://Assets/Textures/UI/health/hearth_40p.png")
var hearth_30p :CompressedTexture2D= load("res://Assets/Textures/UI/health/hearth_30p.png")
var hearth_20p :CompressedTexture2D= load("res://Assets/Textures/UI/health/hearth_20p.png")
var hearth_10p :CompressedTexture2D= load("res://Assets/Textures/UI/health/hearth_10p.png")
var hearth_00p :CompressedTexture2D= load("res://Assets/Textures/UI/health/hearth_00p.png")
func _ready():
      update_bigLife(100)

func update_bigLife(value : int):
      print  ("BigLife value:", value)
      #ausgabe 0- 999
      match value:
            0:
                  texture = hearth_100p
            1-99:
                  texture = hearth_10p
            100-199:
                  texture = hearth_20p
            200-299:
                  texture = hearth_30p
            300-399:
                  texture = hearth_40p
            400-499:
                  texture = hearth_50p
            500-599:
                  texture = hearth_60p
            600-699:
                  texture = hearth_70p
            700-799:
                  texture = hearth_80p
            800-899:
                  texture = hearth_90p
            900-999:
                  texture = hearth_90p
