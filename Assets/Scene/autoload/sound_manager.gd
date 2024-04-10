extends Node2D
class_name soundmanager
const MIN_PITCH :float = 0.9
const MAX_PITCH :float = 1.1
var _pitch_scale: float  = 0

@onready var player_node = get_tree().get_first_node_in_group("player") as Node2D

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
@export var player_attack_sounds : Array[AudioStreamMP3]
@export var player_isCooldown_sounds : Array[AudioStreamMP3]
@export var player_dash_sounds : Array[AudioStreamMP3]
@export var player_getDamage_sounds : Array[AudioStreamMP3]
@export var player_dying_sounds : Array[AudioStreamMP3]
@export var enemys_attack_sounds : Array[AudioStreamMP3]
@export var enemys_hit_sounds : Array[AudioStreamMP3]
@export var enemys_dying_sounds : Array[AudioStreamMP3]
@export var swarm_sound :AudioStreamMP3
############################### LIST GAMEOBJECTS SOUNDS
@export var gameobject_fence_hit_sound : AudioStreamMP3
@export var gameobject_fence_destroying_sound : AudioStreamMP3
@export var gameobject_chest_hit_sound : AudioStreamMP3
@export var gameobject_chest_destoying_sound : AudioStreamMP3
@export var gameobject_region_unlocked_sound : AudioStreamMP3
##################################  LIST AMBIENCE SOUNDS
@export var raven_kraehh_sounds : Array[AudioStreamMP3]
@export var grass_gentleBreeze_sound : AudioStreamMP3
################################## LIST MUSIC
@export var game_music_sounds : Array[AudioStreamMP3]

@onready var menu_music_sound :AudioStreamPlayer = $menu_music_sound
#################################################### VARIABLES

var ui_volume_current : float = 0.4
var gameplay_volume_current : float = 0.4
var music_volume_current : float = 0.4
var ambi_volume_current : float = 0.4

######################################### START MANAGER #####################
func _ready():
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
      sound.set_volume_db(ui_volume_current)
      sound.play()
#### Manage Gameplay sound when game is running
func Play_Gameplay_Sound(sound: AudioStreamPlayer2D, pos : Vector2):
      if sound.playing:
            return
      _pitch_scale = randf_range(MIN_PITCH, MAX_PITCH)
      sound.pitch_scale = _pitch_scale
      sound.set_volume_db(gameplay_volume_current)
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
      sound.set_volume_db(music_volume_current)
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
                  Play_Gameplay_Sound(player_attack_sounds.pick_random(),_pos)
            soundType.s_player_isCooldown_sounds:
                  Play_Gameplay_Sound(player_isCooldown_sounds.pick_random(),_pos)
            soundType.s_player_dash_sounds:
                  Play_Gameplay_Sound(player_dash_sounds.pick_random(),_pos)
            soundType.s_player_getDamage_sounds:
                  Play_Gameplay_Sound(player_getDamage_sounds.pick_random(),_pos)
            soundType.s_player_dying_sounds:
                  Play_Gameplay_Sound(player_dying_sounds.pick_random(),_pos)
            soundType.s_enemys_attack_sounds:
                  Play_Gameplay_Sound(enemys_attack_sounds.pick_random(),_pos)
            soundType.s_enemys_hit_sounds:
                  Play_Gameplay_Sound(enemys_hit_sounds.pick_random(),_pos)
            soundType.s_enemys_dying_sounds:
                  Play_Gameplay_Sound(enemys_dying_sounds.pick_random(),_pos)
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
