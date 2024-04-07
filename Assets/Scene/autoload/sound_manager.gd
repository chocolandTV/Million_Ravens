extends Node2D

const MIN_PITCH :float = 0.9
const MAX_PITCH :float = 1.1
var _pitch_scale: float  = 0

@onready var player_node = get_tree().get_first_node_in_group("player") as Node2D
@onready var gameplay_SoundPlayer : AudioStreamPlayer2D = $AudioSound/Gameplay_AS_Player
@onready var music_SoundPlayer : AudioStreamPlayer =$MusicSound/Music_AS_Player
@onready var ui_SoundPlayer : AudioStreamPlayer = $UISound/UI_AS_Player
@onready var ambi_SoundPlayer : AudioStreamPlayer2D = $AmBiSound/AmBi_AS_Player
enum soundType{
s_ui_click,
s_ui_game_over,
s_ui_click_sounds,
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
@export var ui_click_sounds : Array[AudioStream]
@export var ui_game_over: AudioStream
@export var ui_game_win: AudioStream
@export var ui_player_reached_next_level : AudioStream
@export var ui_player_selected_upgrade : AudioStream
################################  LIST GAMEPLAY SOUNDS
@export var player_attack_sounds : Array[AudioStream]
@export var player_isCooldown_sounds : Array[AudioStream]
@export var player_dash_sounds : Array[AudioStream]
@export var player_getDamage_sounds : Array[AudioStream]
@export var player_dying_sounds : Array[AudioStream]
@export var enemys_attack_sounds : Array[AudioStream]
@export var enemys_hit_sounds : Array[AudioStream]
@export var enemys_dying_sounds : Array[AudioStream]
@export var swarm_sound :AudioStream
############################### LIST GAMEOBJECTS SOUNDS
@export var gameobject_fence_hit : AudioStream
@export var gameobject_fence_destroying : AudioStream
@export var gameobject_chest_hit : AudioStream
@export var gameobject_chest_destoying : AudioStream
@export var gameobject_region_unlocked : AudioStream
##################################  LIST AMBIENCE SOUNDS
@export var raven_kraehh_sounds : Array[AudioStream]
@export var grass_gentleBreeze_sound : AudioStream
################################## LIST MUSIC
@export var game_music_sounds : Array[AudioStream]
@export var menu_music_sound : AudioStream

######################################### START MANAGER #####################
func _ready():
      music_SoundPlayer.finished.connect(on_music_finished)
#### MANAGE MENU SOUND WHEN GAME IS PAUSED
func on_music_finished():
      Emit_Sound(soundType.s_game_music_sounds,Vector2.ZERO)

func Play_UI_Sound(sound: AudioStream):
      if ui_SoundPlayer.playing:
            return
      _pitch_scale = randf_range(MIN_PITCH, MAX_PITCH)
      ui_SoundPlayer.pitch_scale = _pitch_scale
      ui_SoundPlayer.stream = sound
      ui_SoundPlayer.play()
#### Manage Gameplay sound when game is running
func Play_Gameplay_Sound(sound: AudioStream, pos : Vector2):
      if gameplay_SoundPlayer.playing:
            return
      _pitch_scale = randf_range(MIN_PITCH, MAX_PITCH)
      gameplay_SoundPlayer.pitch_scale = _pitch_scale
      gameplay_SoundPlayer.stream = sound
      gameplay_SoundPlayer.global_position = pos
      gameplay_SoundPlayer.play()
func Play_Ambience_Sound(sound: AudioStream, pos : Vector2):
      if ambi_SoundPlayer.playing:
            return
      _pitch_scale = randf_range(MIN_PITCH, MAX_PITCH)
      ambi_SoundPlayer.pitch_scale = _pitch_scale
      ambi_SoundPlayer.stream = sound
      ambi_SoundPlayer.global_position = pos
      ambi_SoundPlayer.play()
#### Manage Music loop
func Play_Music_Sound(sound : AudioStream):
      _pitch_scale = randf_range(MIN_PITCH, MAX_PITCH)
      music_SoundPlayer.pitch_scale = _pitch_scale
      music_SoundPlayer.stream = sound
      music_SoundPlayer.play()
#### Global Sound Function cast
func Emit_Sound(_soundType : soundType, _pos : Vector2):
      match _soundType:
            soundType.s_ui_click_sounds:
                  Play_UI_Sound(ui_click_sounds.pick_random())
            soundType.s_ui_game_over:
                  Play_UI_Sound(ui_game_over)
            soundType.s_ui_game_win:
                  Play_UI_Sound(ui_game_win)
            soundType.s_ui_player_reached_next_level:
                  Play_UI_Sound(ui_player_reached_next_level)
            soundType.s_ui_player_selected_upgrade:
                  Play_UI_Sound(ui_player_selected_upgrade)
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
                  Play_Gameplay_Sound(swarm_sound,_pos)
            soundType.s_gameobject_fence_hit:
                  Play_Gameplay_Sound(gameobject_fence_hit,_pos)
            soundType.s_gameobject_fence_destroying:
                  Play_Gameplay_Sound(gameobject_fence_destroying,_pos)
            soundType.s_gameobject_chest_hit:
                  Play_Gameplay_Sound(gameobject_chest_hit,_pos)
            soundType.s_gameobject_chest_destoying:
                  Play_Gameplay_Sound(gameobject_chest_destoying,_pos)
            soundType.s_gameobject_region_unlocked:
                  Play_Gameplay_Sound(gameobject_region_unlocked,_pos)
            soundType.s_raven_kraehh_sounds:
                  Play_Ambience_Sound(raven_kraehh_sounds.pick_random(),_pos)
            soundType.s_grass_gentleBreeze_sound:
                  Play_Ambience_Sound(grass_gentleBreeze_sound,_pos)
            soundType.s_game_music_sounds:
                  Play_Music_Sound(game_music_sounds.pick_random())
            soundType.s_menu_music_sound:
                  Play_Music_Sound(menu_music_sound)
