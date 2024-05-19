extends StaticBody2D
class_name Region_Text_Class

@export var region_text : String

var isPlayerInRange : bool  = false
var raven_Lord_ragecounter : float = 0
var game_state : int = 0
@onready var sprite : AnimatedSprite2D =$Node2D/AnimatedSprite2D
@onready var raven_ui_helper : Node2D = $Raven_lord_UI
# REGION COIN OBJECTS TO ACTIVATE
@onready var sprite2D_Coins : Sprite2D =$Node2D/Sprite2D_Coins_to_activate
@onready var sprite2D_Coin_text : Label =$Node2D/Sprite2D_Coins_to_activate/Label_Coins_needed
func _ready():
      $%Label.text = region_text
      $AgressionComponent.body_entered.connect(player_entered_zone)
      $AgressionComponent.body_exited.connect(player_exited_zone)
      GameEvents.raven_died.connect(raven_died_in_zone)
      GameEvents.midGame_region_boss_spawned.connect(on_boss_dead)
      


func get_region_text():
      return region_text

func set_region_text(_text : String):
      region_text = _text


func player_entered_zone(body : Node2D):
      isPlayerInRange = true

func player_exited_zone(body : Node2D):
      isPlayerInRange = false

func raven_died_in_zone():
      if isPlayerInRange && game_state == 1:
            raven_Lord_ragecounter += 0.01
            # ui update
            raven_ui_helper.on_region_collect_raven(raven_Lord_ragecounter)
            # GameEvents.ui_update_collectable.emit(0,raven_Lord_ragecounter)

########### WHEN PLAYER TRIGGERS THE FLAG ##########################
func _on_health_changed():
      $AnimationPlayer.play("wriggle")
      if game_state ==0:
            #Change Color and State
            check_coins()

      if raven_Lord_ragecounter >=1 && game_state ==1:
            GameEvents.midGame_region_raven_cleared.emit(global_position)
            raven_Lord_ragecounter = 0
            # REGION FILLED WITH LORD
            game_state = 2
            print ("region: ravens cleared, boss will spawn")
            #SPAWN RAVEN LORD
      if game_state ==3: # BOSS DOWN FINISHED 
            #add particle system
            print ("region: game done gratz + 10000 exp / score")
            sprite.modulate = Color.GREEN
            
func check_coins():
      #result
      if Highscore_Manager.on_region_activate_with_coins():
            sprite.modulate = Color.YELLOW
            game_state = 1 #RAVEN LORD WILL BE SPAWNING WHEN RAVENS GET KILLED
            print ("region: game started")
            raven_ui_helper.visible = true
            # SoundManager.Emit_Sound(SoundManager.soundType.s_gameobject_region_unlocked,Vector2.ZERO)
      else:
            # SoundManager.Emit_Sound(SoundManager.soundType.s_gameobject_fence_hit,Vector2.ZERO)
            sprite.modulate = Color.ORANGE_RED
            print ("Region_Event: Not enough Coins!")
            sprite2D_Coins.visible = true
            sprite2D_Coin_text.text = "X %s" %(Highscore_Manager.current_RavenLords+1)
            #SetText to Region progress

func on_boss_dead(health_component : HealthComponent):
      if game_state == 2:
            health_component.died.connect(_on_boss_dead_event)

func _on_boss_dead_event(_damageType :int):
      game_state = 3
      GameEvents.highscore_ravenlord_collected.emit()
      print ("region: game done gratz + 10000 exp / score")
      sprite.modulate = Color.GREEN
      raven_ui_helper.visible = false
      # SoundManager.Emit_Sound(SoundManager.soundType.s_gameobject_region_unlocked,Vector2.ZERO)

