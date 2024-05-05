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

var current_level_points :int  =0
# Multiplier Value
@onready var highscore_multiplier_text : Label = $%Value_multiplier
# BigLife Sprite
@onready var bigLife_sprite : Sprite2D = $%BigLife_Sprite
func _ready():
      print(bigLife_sprite.name)
      experience_manager.level_up.connect(on_level_up_change_ui)
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
      highscore_value_text.text = str(highscore_manager.current_highscore).lpad(4,"0")
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
      value_coin.text  = "X 0"
      value_Feather.text = "X 0"
      highscore_multiplier_text.text = "1"
      highscore_value_text.text = "0"
      on_lifeChange_UI(0)

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
            value_Feather.text = "X "+str(value)
      if switch == 1:
            value_coin.text =  "X "+str(value)

func _showupgrades(_bool :bool):
      _player_Ability_Container.visible = _bool
# GET INPUT 1,2,3,4 if level up == applyUpgrade
func _input(event):
      if event.is_action_pressed("upgrade_button_01") && current_level_points > 0:
            applyUpgrade(0)
      if event.is_action_pressed("upgrade_button_02") && current_level_points > 0:
            applyUpgrade(1)
      if event.is_action_pressed("upgrade_button_03") && current_level_points > 0:
            applyUpgrade(2)
      if event.is_action_pressed("upgrade_button_04") && current_level_points > 0:
            applyUpgrade(3)
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
      if current_level_points > 0:
            current_level_points -=1
            GameEvents.ability_upgrade_Button.emit(button_value)
            if current_level_points <= 0:
                  _showupgrades(false)

func on_lifeplus_UI(value:int):
      bigLife_sprite.update_newlife(value)

func on_lifeChange_UI(value : int):
      bigLife_sprite.update_bigLife(value)


func update_highscore_multiplier(type : int):
      match type: 
            1:
                  # add effect increase 
                  highscore_multiplier_text.text = "x " + str(settings.gv_score_multiplier)
            2:
                  # add effect for reset to 1
                  highscore_multiplier_text.text = "x " + str(settings.gv_score_multiplier)