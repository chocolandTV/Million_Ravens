extends CharacterBody2D
@export var highscore_amount : int =  1
const speed :float  =500.0

func _ready():
      $Area2D.area_entered.connect(on_area_entered)

func on_area_entered(other_area : Area2D):
      GameEvents.emit_highscore_orb_collected(highscore_amount)
      queue_free()


func _process(_delta):
     
      #get direction
      var direction = get_direction_to_player()
      #start flying
      velocity = direction * speed
      move_and_slide()
      # increase speed

func get_direction_to_player():
      #get player
      var player_node = get_tree().get_first_node_in_group("player") as Node2D
      if player_node != null:
            return (player_node.global_position - global_position).normalized()
      #return if not null
      return Vector2.ZERO
