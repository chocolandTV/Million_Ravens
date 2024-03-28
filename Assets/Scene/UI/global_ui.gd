extends CanvasLayer
# TOP TEXT VARIABLES 
@onready var highscore_value_text : Label = $%Value_Highscore
@onready var value_fps_text : Label =$%Value_FPS
@onready var value_playerLevel : Label = $%Value_PlayerLevel
@onready var value_playername : Label  =$%Value_PlayerName
# BOTTOM TEXT VARIABLES
@onready var value_ravenkills : Label  =$%Value_Ravenkills
@onready var value_Feather : Label = $%Feather_Value
@onready var value_coin : Label  =$%Coin_Value
# MANAGERS 
@onready var highscore_manager : Highscore_Manager = get_node("/root/Highscore_Manager")
@onready var settings : Global_Variables = get_node("/root/GlobalVariables")
@export var experience_manager : ExperienceManager
@export var upgrade_manager : UpgradeManager
@export var abilityReady : Array[TextureRect]

func _ready():
      experience_manager.level_up.connect(on_level_up_change_ui)
      GameEvents.ability_upgrade_added.connect(on_ability_levelup)
      #get ravenKilledAmount
      highscore_manager.UI_ravenkilled.connect(on_ravenscore_update)
      #get ability status event
      GameEvents.ability_status_changed.connect(on_ability_status_change)
      # RESET ALL STATS
      reset_stats()
      
func _process(delta):
      value_fps_text.text = ("FPS: %d" % Engine.get_frames_per_second())
      highscore_value_text.text = str(highscore_manager.current_highscore)
# when player levels up
func on_level_up_change_ui(new_level : int):
      value_playerLevel.text = str(new_level)
#when ability levels up
func on_ability_levelup(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
      pass
      # var pawAttackAndRate :String = current_upgrades[0]
      # value_pawAttackAndRate.text =  
func on_ability_status_change(abilityType: int,abilityStatus :bool):
      # DO ABILITY 1 abilityStatus
      abilityReady[abilityType].visible = abilityStatus

func on_ravenscore_update(amount : int):
      value_ravenkills.text = str(amount) + "kills"

func reset_stats():
      value_ravenkills.text = "0 kills"
      value_playerLevel.text = "1"
      value_coin.text  = "0"
      value_Feather.text = "0"

func UpdatePlayerName():
      print ("update playername")
      value_playername.text = settings.gv_Settings["player_name"]