extends CanvasLayer
# TOP TEXT VARIABLES 
@onready var highscore_value_text : Label = $%Value_Highscore
@onready var value_fps_text : Label =$%Value_FPS
@onready var value_playerLevel : Label = $%Value_PlayerLevel
# BOTTOM TEXT VARIABLES
@onready var value_pawAttackAndRate : Label  =$%Value_PawAttackLevel
@onready var Value_AutoAttackLevel : Label = $%Value_AutoAttackLevel
@onready var Value_MovementSpeed : Label  =$%Value_MovementSpeed
# MANAGERS 
@export var highscoremanager : HighscoreManager
@export var experience_manager : ExperienceManager
@export var upgrade_manager : UpgradeManager

func _ready():
      experience_manager.level_up.connect(on_level_up_change_ui)
      GameEvents.ability_upgrade_added.connect(on_ability_levelup)
func _process(delta):
      value_fps_text.text = ("FPS: %d" % Engine.get_frames_per_second())
      highscore_value_text.text = str(highscoremanager.current_highscore)
# when player levels up
func on_level_up_change_ui(new_level : int):
      value_playerLevel.text = str(new_level)
#when ability levels up
func on_ability_levelup(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
      pass
      # var pawAttackAndRate :String = current_upgrades[0]
      # value_pawAttackAndRate.text =  

