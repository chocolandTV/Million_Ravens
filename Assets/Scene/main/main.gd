extends Node2D
# #################################################################################### MAIN.GD
# MASTER GAME LOOP HANDLER
# HANDLE MENUES 
# HANDLES GAME PAUSE 
# #################################################################################### MAIN.GD
@export var end_screen_scene : PackedScene

@onready var highscore_manager : Highscore_Manager = get_node("/root/Highscore_Manager")
@onready var canvas_Layer_menu : CanvasLayer = $%Main_Menu
@onready var canvas_Layer_Global_UI : CanvasLayer = $%Global_UI
@onready var canvas_Layer_Arena_Time_UI : CanvasLayer = $%ArenaTimeUI
@onready var canvas_Layer_Experience_bar : CanvasLayer = $%ExperienceBar

var game_state : int = 0
var isMenuOpened : bool = true
# Called when the node enters the scene tree for the first time.
func _ready():
	GameEvents.player_died.connect(on_highscore_died)
	game_state = 0
	get_tree().paused = false
	GameEvents.menu_switch.connect(on_menu_switch)

# RETURN GAMESTATE FOR ALL MANAGERS
func isGameStatePaused():
	return isMenuOpened

func on_highscore_died():
	var end_screen_instance = end_screen_scene.instantiate()
	add_child(end_screen_instance)
	end_screen_instance.set_defeat()

func switchMenu():
	isMenuOpened = !isMenuOpened
	canvas_Layer_menu.visible= isMenuOpened
	get_tree().paused = isMenuOpened
	canvas_Layer_Global_UI.visible  =!isMenuOpened
	canvas_Layer_Arena_Time_UI.visible =!isMenuOpened
	canvas_Layer_Experience_bar.visible = !isMenuOpened

func on_menu_switch():
	switchMenu()

func on_playerName_changed_Submit_to_UI():
	canvas_Layer_Global_UI.UpdatePlayerName()
func _input(event):
	if event.is_action_pressed("openmenu"):
		switchMenu()