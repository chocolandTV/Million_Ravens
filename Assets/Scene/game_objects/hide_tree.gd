extends StaticBody2D

@onready var area_hide :Area2D =$Hide_Area2D

func _ready():
      area_hide.area_entered.connect(on_area_entered)
      area_hide.area_exited.connect(on_area_exit)

func on_area_entered(area :Area2D):
      print("player entered")
      #HIDE PLAYER
      # DISABLE SPAWNING / DELETE CURRENT SPAWN POOL
      # GLOBAL EVENT HIDE MINIGAME


func on_area_exit(Area :Area2D):
      print("player exit")
      # UNHIDE PLAYER
      # ENABLE SPAWNING
      # IF MINIGAME FAILS  EXIT 
