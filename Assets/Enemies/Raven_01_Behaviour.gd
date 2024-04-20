extends CharacterBody2D

class_name Enemy01_Ravii

# @onready var hit_box : Area2D = $HitboxComponent
@onready var anim : AnimationPlayer = $AnimationPlayer
@onready var timer : Timer = $Timer

const speed : float  = 325.0
const mutation_multiplier_chance : int = 5
const damage :int  = 1 
var isCooldown : bool  = false

# damage Type check equals with enemy
var damage_type_enemy : int = 0
var player_node : Node2D
func _ready():
      timer.timeout.connect(on_timer_timeouti)
      #get player
      player_node = get_tree().get_first_node_in_group("player") as Node2D
      #get lucky int
      if get_node("/root/GlobalVariables").gv_lucky_catmint < mutation_multiplier_chance:
            on_colorEvent_triggered()

func _process(_delta):
      if isCooldown:
            return
      #get direction
      var direction = get_direction_to_player()
      #start flying
      velocity = direction * speed
      move_and_slide()

func get_direction_to_player():
      #get player
      if player_node != null:
            return (player_node.global_position - global_position).normalized()
      #return if not null
      return Vector2.ZERO
func on_raven_01_knockback():
      anim.play("Knockback")
      global_position += -get_direction_to_player() * damage * 10
      isCooldown = true
      timer.start()

func on_timer_timeouti():
      isCooldown = false

func on_colorEvent_died(_damage_type : int):
      if _damage_type == damage_type_enemy:
            get_node("/root/GlobalVariables").increase_multiplier()
            GameEvents.ui_update_highscore_multiplier.emit(1)
            print("increase multiplier")
      if damage_type_enemy == 0:
            return
      if damage_type_enemy != damage_type_enemy:
            print("reset Multiplier")
            get_node("/root/GlobalVariables").reset_multiplier()
            GameEvents.ui_update_highscore_multiplier.emit(0)
# func on Ready if raven chanced 0,2%
func on_colorEvent_triggered():
      if randi_range(0,10) >=5:
            print("ColorEvent_Cyan")
            $Sprite2D.modulate = Color.CYAN
            damage_type_enemy = 1
      else:
            print("ColorEvent_Red")
            $Sprite2D.modulate = Color.RED
            damage_type_enemy = 2
      $HealthComponent.died.connect(on_colorEvent_died)
