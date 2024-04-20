extends Node2D
class_name soundmanager
const MIN_PITCH :float = 0.9
const MAX_PITCH :float = 1.1
var _pitch_scale: float  = 0

@onready var player_node = get_tree().get_first_node_in_group("player") as Node2D
@onready var settings : Global_Variables = get_node("/root/GlobalVariables")
enum soundType{
s_ui_click,
s_ui_game_over,
s_ui_game_win,
s_ui_player_reached_next_level,
s_ui_player_selected_upgrade,
s_player_attack_sounds,
s_player_isCooldown_sounds,
s_player_dash_sounds,
s_player_getDamage_sounds,
s_player_dying_sounds,
s_enemys_attack_sounds,
s_enemys_hit_sounds,
s_enemys_dying_sounds,
s_swarm_sound,
s_gameobject_fence_hit,
s_gameobject_fence_destroying,
s_gameobject_chest_hit,
s_gameobject_chest_destoying,
s_gameobject_region_unlocked,
s_raven_kraehh_sounds,
s_grass_gentleBreeze_sound,
s_game_music_sounds,
s_menu_music_sound
}
############### LIST UI SOUND
@onready var ui_click_sounds =$ui_click
@onready var ui_game_over_sound =$ui_click
@onready var ui_game_win_sound =$ui_click
@onready var ui_player_reached_next_level_sound =$ui_click
@onready var ui_player_selected_upgrade_sound = $ui_click
################################  LIST GAMEPLAY SOUNDS
@onready var player_attack_sounds :AudioStreamPlayer = $player_attack_sounds
@onready var player_isCooldown_sounds :AudioStreamPlayer =$player_isCooldown_sounds
@onready var player_dash_sounds :AudioStreamPlayer =$player_dash_sounds
@onready var player_getDamage_sounds :AudioStreamPlayer=$player_getDamage_sounds
@onready var player_dying_sounds :AudioStreamPlayer=$player_dying_sounds
@onready var enemys_attack_sounds :AudioStreamPlayer2D=$enemy_01_attack
## fehlt enemy 02,03,04,05
@onready var enemys_hit_sounds :AudioStreamPlayer2D=$enemy_02_attack
@onready var enemys_dying_sounds :AudioStreamPlayer2D=$enemy_03_attack
@onready var swarm_sound :AudioStreamPlayer2D=$enemy_swarm

############################### LIST GAMEOBJECTS SOUNDS
@onready var gameobject_fence_hit_sound :AudioStreamPlayer2D =$gameObject_fence_hit
@onready var gameobject_fence_destroying_sound :AudioStreamPlayer2D=$gameObject_fence_dead
@onready var gameobject_chest_hit_sound :AudioStreamPlayer2D=$gameObject_chest_hit
@onready var gameobject_chest_destoying_sound :AudioStreamPlayer2D=$gameObject_chest_dead
@onready var gameobject_region_unlocked_sound :AudioStreamPlayer2D=$gameObject_region_unlocked
##################################  LIST AMBIENCE SOUNDS
@onready var raven_kraehh_sounds :AudioStreamPlayer2D=$ambience_raven_kraeh
@onready var grass_gentleBreeze_sound :AudioStreamPlayer2D=$ambience_grass_gentleBreeze
# STORM SOUND
################################## LIST MUSIC
@onready var game_music_sounds :AudioStreamPlayer=$music_01_christyBacon

@onready var menu_music_sound :AudioStreamPlayer = $menu_music_sound
#################################################### VARIABLES
@onready var sfx_master_index = AudioServer.get_bus_index("Master")
@onready var sfx_sound_index= AudioServer.get_bus_index("Sound")
@onready var sfx_music_index= AudioServer.get_bus_index("Music")
@onready var sfx_ambience_index= AudioServer.get_bus_index("Ambience")

######################################### START MANAGER #####################
func _ready():
      GameEvents.menu_sound_volume_change.connect(on_menu_sound_volume_change)
      #music_SoundPlayer.finished.connect(on_music_finished)
      Emit_Sound(soundType.s_menu_music_sound,Vector2.ZERO)
#### MANAGE MENU SOUND WHEN GAME IS PAUSED
func on_music_finished():
      Emit_Sound(soundType.s_game_music_sounds,Vector2.ZERO)

func Play_UI_Sound(sound: AudioStreamPlayer):
      if sound.playing:
            return
      _pitch_scale = randf_range(MIN_PITCH, MAX_PITCH)
      sound.pitch_scale = _pitch_scale
      sound.play()
#### Manage Player sound on position 0
func Play_Player_Sound(sound: AudioStreamPlayer):
      if sound.playing:
            return
      _pitch_scale = randf_range(MIN_PITCH, MAX_PITCH * 1.1)
      sound.pitch_scale = _pitch_scale
      sound.play()
#### Manage Gameplay sound when game is running
func Play_Gameplay_Sound(sound: AudioStreamPlayer2D, pos : Vector2):
      if sound.playing:
            return
      _pitch_scale = randf_range(MIN_PITCH, MAX_PITCH)
      sound.pitch_scale = _pitch_scale
      sound.global_position = pos
      sound.play()
func Play_Ambience_Sound(sound: AudioStreamPlayer2D, pos : Vector2):
      if sound.playing:
            return
      _pitch_scale = randf_range(MIN_PITCH, MAX_PITCH)
      sound.pitch_scale = _pitch_scale
      sound.global_position = pos

      sound.play()
#### Manage Music loop
func Play_Music_Sound(sound : AudioStreamPlayer):
      sound.play()
#### Global Sound Function cast
func Emit_Sound(_soundType : soundType, _pos : Vector2):
      match _soundType:
            soundType.s_ui_click:
                  Play_UI_Sound(ui_click_sounds)
            soundType.s_ui_game_over:
                  Play_UI_Sound(ui_game_over_sound)
            soundType.s_ui_game_win:
                  Play_UI_Sound(ui_game_win_sound)
            soundType.s_ui_player_reached_next_level:
                  Play_UI_Sound(ui_player_reached_next_level_sound)
            soundType.s_ui_player_selected_upgrade:
                  Play_UI_Sound(ui_player_selected_upgrade_sound)
            soundType.s_player_attack_sounds:
                  Play_Player_Sound(player_attack_sounds)
            soundType.s_player_isCooldown_sounds:
                  Play_Player_Sound(player_isCooldown_sounds)
            soundType.s_player_dash_sounds:
                  Play_Player_Sound(player_dash_sounds)
            soundType.s_player_getDamage_sounds:
                  Play_Player_Sound(player_getDamage_sounds)
            soundType.s_player_dying_sounds:
                  Play_Player_Sound(player_dying_sounds)
            soundType.s_enemys_attack_sounds:
                  Play_Gameplay_Sound(enemys_attack_sounds,_pos)
            soundType.s_enemys_hit_sounds:
                  Play_Gameplay_Sound(enemys_hit_sounds,_pos)
            soundType.s_enemys_dying_sounds:
                  Play_Gameplay_Sound(enemys_dying_sounds,_pos)
            soundType.s_swarm_sound:
                  Play_Gameplay_Sound(ui_click_sounds,_pos)
            soundType.s_gameobject_fence_hit:
                  Play_Gameplay_Sound(ui_click_sounds,_pos)
            soundType.s_gameobject_fence_destroying:
                  Play_Gameplay_Sound(ui_click_sounds,_pos)
            soundType.s_gameobject_chest_hit:
                  Play_Gameplay_Sound(ui_click_sounds,_pos)
            soundType.s_gameobject_chest_destoying:
                  Play_Gameplay_Sound(ui_click_sounds,_pos)
            soundType.s_gameobject_region_unlocked:
                  Play_Gameplay_Sound(ui_click_sounds,_pos)
            soundType.s_raven_kraehh_sounds:
                  Play_Ambience_Sound(ui_click_sounds,_pos)
            soundType.s_grass_gentleBreeze_sound:
                  Play_Ambience_Sound(ui_click_sounds,_pos)
            soundType.s_game_music_sounds:
                  Play_Music_Sound(menu_music_sound)
            soundType.s_menu_music_sound:
                  Play_Music_Sound(menu_music_sound)
#Sound_UI_Change integer for type 1:Master 2: Music 3: Sound 4: Ambience, float for value 0-1
func on_menu_sound_volume_change(type:int, value : float):
      match type:
            0:
                  AudioServer.set_bus_volume_db(sfx_master_index, linear_to_db(value))
                  settings.gv_Settings["setting_volume_master"] = value
            1:
                  AudioServer.set_bus_volume_db(sfx_music_index, linear_to_db(value))
                  settings.gv_Settings["setting_volume_music"] = value
            2:
                  AudioServer.set_bus_volume_db(sfx_sound_index, linear_to_db(value))
                  settings.gv_Settings["setting_volume_sound"] = value
            3:
                  AudioServer.set_bus_volume_db(sfx_ambience_index, linear_to_db(value))
                  settings.gv_Settings["setting_volume_ambience"] = value