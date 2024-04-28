extends Node
@onready var splash = $%firstSplash
@onready var menu = $%Menu
@onready var playername_textField : LineEdit = $%LineEdit
@onready var setting_menu : MarginContainer = $%Setting_Menu
# MANAGERS
@onready var global_vars : Global_Variables = get_node("/root/GlobalVariables")

@onready var filemanager : FileManager = get_node("/root/File_Manager")
@onready var highscore_ui : CanvasLayer = $%Highscore_Menu

# START BUTTON TEXT 
@onready var startButton_text : Button = $%Button_Start

# CREDIT 
@onready var creditButton : Button =$%Button_Credit
@onready var credit_Panel : MarginContainer  = $%Credit_Panel
@onready var credit_HighFrame_Image : ParallaxBackground = $%ParallaxBackground
# GLOBAL UI
@export var global_UI : CanvasLayer
#Original Background
@onready var base_background : TextureRect =$%base_BackgroundImage
# TOGGLE SETTING VARIABLE
var  isCreditsOn :bool = false
var setting_enabled :bool = false
var isHighscoreOn :bool = false

func _ready():
      # Load Savegame Data if persists
      filemanager.load_game()
      playername_textField.text_submitted.connect(on_playername_textfield_submitted)
      GameEvents.highscore_button_pressed.connect(on_highscore_button_pressed)
      creditButton.pressed.connect(_on_credit_button_pressed)
      

func _on_timer_timeout():
      splash.visible = false
      menu.visible = true
func setParallax(value : bool):
      $%ParallaxBackground.visible = value
func _on_quit_button_pressed():
      filemanager.save_game()
      get_tree().quit()
################### START BUTTON ####################
func _on_start_button_pressed():
      startButton_text.text = "Resume"
      get_tree().paused = false
      GameEvents.menu_switch.emit()
      SoundManager.Emit_Sound(SoundManager.soundType.s_ui_click,Vector2.ZERO)

func _on_credit_button_pressed():
      isCreditsOn = !isCreditsOn
      #base_background.visible = !isCreditsOn
      #credit_HighFrame_Image.visible = isCreditsOn
      credit_Panel.visible = isCreditsOn
      credit_Panel.resetName()
      if isCreditsOn:
            setting_enabled = !isCreditsOn
            setting_menu.visible = setting_enabled
      SoundManager.Emit_Sound(SoundManager.soundType.s_ui_click,Vector2.ZERO)

func _on_button_highscore_pressed():
      #TOGGLE HIGHSCORE
      isHighscoreOn = !isHighscoreOn
      if isHighscoreOn:
            highscore_ui.on_CanvasLayer_activate()
      splash.visible = false
      setting_enabled = !isHighscoreOn
      global_UI.visible = false
      setting_menu.visible = false
      isCreditsOn = !isHighscoreOn
      credit_Panel.visible = false
      # Turn highscore On
      highscore_ui.visible = true
      SoundManager.Emit_Sound(SoundManager.soundType.s_ui_click,Vector2.ZERO)

func _on_highscore_back_button_pressed():
      splash.visible = false
      menu.visible = true
      global_UI.visible = false
      # Turn highscore On
      highscore_ui.visible = false
      SoundManager.Emit_Sound(SoundManager.soundType.s_ui_click,Vector2.ZERO)

func _on_button_pressed():
      on_playername_textfield_submitted(playername_textField.text)
      SoundManager.Emit_Sound(SoundManager.soundType.s_ui_click,Vector2.ZERO)

func on_playername_textfield_submitted(_text : String):
      global_vars.gv_Settings["player_name"]  = _text
      HighscoreUiSystem._change_player_name(_text)
      get_parent().on_playerName_changed_Submit_to_UI()
      SoundManager.Emit_Sound(SoundManager.soundType.s_ui_click,Vector2.ZERO)

func _on_button_settings_pressed():
      toggleSettingMenu()

func toggleSettingMenu():
      setting_enabled = !setting_enabled
      setting_menu.visible = setting_enabled
      if setting_enabled:
            isCreditsOn = false
            credit_Panel.visible = isCreditsOn
      # highscore_ui_system._get_player_name()
      # playername_textField.placeholder_text = global_vars.gv_Settings["player_name"]
      if !setting_enabled:
            filemanager.save_game()
      SoundManager.Emit_Sound(SoundManager.soundType.s_ui_click,Vector2.ZERO)

func on_highscore_button_pressed():
      _on_button_highscore_pressed()
