extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	GameEvents.emit_winGame_boss_down_event()

