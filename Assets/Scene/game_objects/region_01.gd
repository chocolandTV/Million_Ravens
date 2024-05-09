extends StaticBody2D
class_name Region_Text_Class

@export var region_text : String

var isPlayerInRange : bool  = false
var raven_Lord_ragecounter : float = 0
var game_state : int = 0
@onready var sprite : AnimatedSprite2D =$Node2D/AnimatedSprite2D
@onready var raven_ui_helper : Node2D = $Raven_lord_UI
func _ready():
      $%Label.text = region_text
      $AgressionComponent.body_entered.connect(player_entered_zone)
      $AgressionComponent.body_exited.connect(player_exited_zone)
      


func get_region_text():
      return region_text

func set_region_text(_text : String):
      region_text = _text


func player_entered_zone(body : Node2D):
      isPlayerInRange = true
      print ("player entered region zone")
      GameEvents.raven_died.connect(raven_died_in_zone)
      GameEvents.midGame_region_boss_spawned.connect(on_boss_dead)
      
func player_exited_zone(body : Node2D):
      isPlayerInRange = false
      print ("player left region zone")
      GameEvents.raven_died.disconnect(raven_died_in_zone)
      GameEvents.midGame_region_boss_spawned.disconnect(on_boss_dead)

func raven_died_in_zone():
      if isPlayerInRange && game_state == 1:
            raven_Lord_ragecounter += 0.01
            # ui update
            GameEvents.ui_update_collectable.emit(0,raven_Lord_ragecounter)
            print ("RavenLord_Indicator: ", raven_Lord_ragecounter)

########### WHEN PLAYER TRIGGERS THE FLAG ##########################
func _on_health_changed():
      $AnimationPlayer.play("wriggle")
      if game_state ==0:
            #Change Color and State
            sprite.modulate = Color.YELLOW
            game_state = 1 #RAVEN LORD WILL BE SPAWNING WHEN RAVENS GET KILLED
            print ("region: game started")
            raven_ui_helper.visible = true
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
            

func on_boss_dead(health_component : HealthComponent):
      health_component.died.connect(_on_boss_dead_event)

func _on_boss_dead_event(_damageType :int):
      game_state = 3
      GameEvents.highscore_ravenlord_collected.emit()
      print ("region: game done gratz + 10000 exp / score")
      sprite.modulate = Color.GREEN
      raven_ui_helper.visible = false

