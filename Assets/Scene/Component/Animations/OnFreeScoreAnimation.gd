extends Node2D

@export var score_value : int

func _ready():
      $%Label.text = "+ %d" % score_value