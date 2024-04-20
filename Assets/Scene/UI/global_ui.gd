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


#Ability Upgrades
@onready var _player_Ability_Container : MarginContainer = $%Player_Ability_Container
@onready var _atk_up_Button : TextureButton =$%atk_up_Button
@onready var _atk_up_text :Label =$%atk_up_text
@onready var _atkspeed_up_Button : TextureButton =$%atkspeed_up_Button
@onready var _atkspeed_up_text : Label =$%atkspeed_up_text
@onready var _movspeed_up_Button : TextureButton =$%movspeed_up_Button
@onready var _movspeed_up_text : Label =$%movspeed_up_text
@onready var _lifeplus_up_Button : TextureButton =$%lifeplus_up_Button
@onready var _lifeplus_up_text : Label = $%lifeplus_up_text

# Life Container + Icons
@export var life_icon_scene : PackedScene
@onready var life_container : HFlowContainer  =$%HFlowContainer
var health_array : Array[Panel]
var current_level_points :int  =0

# Multiplier Value
@onready var highscore_multiplier_text : Label = $%Value_multiplier
func _ready():
      experience_manager.level_up.connect(on_level_up_change_ui)
      #GameEvents.ability_upgrade_added.connect(on_ability_levelup)
      #get ravenKilledAmount
      highscore_manager.UI_ravenkilled.connect(on_ravenscore_update)
      # ability upgrade buttons
      _atk_up_Button.pressed.connect(_on_atk_up_Button)
      _atkspeed_up_Button.pressed.connect(_on_atkspeed_up)
      _movspeed_up_Button.pressed.connect(on_movspeed_up)
      _lifeplus_up_Button.pressed.connect(on_lifeplus_up)
      #update LifeCointainer
      GameEvents.ability_upgrade_newLife.connect(on_lifeplus_UI)
      GameEvents.PlayerLife_UI_update.connect(on_lifeChange_UI)
      #show globalUI event
      GameEvents.level_up_show_upgrademenu.connect(_on_levelup_update_upgrades)
      #update collectables
      GameEvents.ui_update_collectable.connect(update_collectable_text)
      #update Highscore multiplier
      GameEvents.ui_update_highscore_multiplier.connect(update_highscore_multiplier)
      # RESET ALL STATS
      reset_stats()
      
func _process(delta):
      value_fps_text.text = ("FPS: %d" % Engine.get_frames_per_second())
      highscore_value_text.text = str(highscore_manager.current_highscore)
# when player levels up
func on_level_up_change_ui(new_level : int):
      
      value_playerLevel.text = str(new_level)
#when ability levels up
# func on_ability_levelup(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
#       pass
#       # var pawAttackAndRate :String = current_upgrades[0]
#       # value_pawAttackAndRate.text =  

func on_ravenscore_update(amount : int):
      value_ravenkills.text = str(amount) + "kills"

func reset_stats():
      value_ravenkills.text = "0 kills"
      value_playerLevel.text = "1"
      value_coin.text  = "0"
      value_Feather.text = "0"
      highscore_multiplier_text.text = "1"

func UpdatePlayerName():
      print ("update playername")
      value_playername.text = settings.gv_Settings["player_name"]
# On Level Up
func _on_levelup_update_upgrades():
      current_level_points +=1 
      _showupgrades(true)
      update_ability_text()

func update_ability_text():
      _atk_up_text.text = "%d + 1 Dmg" % settings.gv_Settings["paw_ability_damage_level"]
      _atkspeed_up_text.text = "%d - 100 ms" % settings.gv_Settings["paw_ability_cooldown_level"]
      _movspeed_up_text.text = "%d + 2,5 m/s" % settings.gv_Settings["player_movement_speed_level"]
      _lifeplus_up_text.text = "%d + 1 Life" % settings.gv_Settings["player_health_level"]

func update_collectable_text(switch : int, value :int):
      if switch == 0:
            value_Feather.text = str(value)
      if switch == 1:
            value_coin.text =  str(value)

func _showupgrades(_bool :bool):
      
      _player_Ability_Container.visible = _bool

# BUTTON UPGRADES
func _on_atk_up_Button():
      applyUpgrade(0)
func _on_atkspeed_up():
      applyUpgrade(1)
func on_movspeed_up():
     applyUpgrade(2)
func on_lifeplus_up():
      applyUpgrade(3)

func applyUpgrade(button_value : int):
      if current_level_points <= 0:
            _showupgrades(false)
      current_level_points -=1
      GameEvents.emit_ability_upgrade_Button(button_value)

func on_lifeplus_UI():
      var life_instance = life_icon_scene.instantiate()
      life_container.add_child(life_instance)
      health_array.append(life_instance)

func on_lifeChange_UI(value : int):
      var county :int = 0
      for i in health_array:
            if value > county:
                  i.setstatus(true)
            else:
                  i.setstatus(false)
            county += 1

func update_highscore_multiplier(type : int):
      match type: 
            1:
                  # add effect increase 
                  highscore_multiplier_text.text = str(settings.gv_score_multiplier)
            2:
                  # add effect for reset to 1
                  highscore_multiplier_text.text = str(settings.gv_score_multiplier)