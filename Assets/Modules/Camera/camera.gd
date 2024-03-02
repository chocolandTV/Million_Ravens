extends Camera2D
@export var smoothLerp =20.0
var target_position = Vector2.ZERO

func _ready():
      # set to default
      make_current()

func _process(delta):
      getPlayer()
      global_position = global_position.lerp(target_position, 1.0 -exp(-delta * smoothLerp))

func getPlayer():
      #get player
      var player_node = get_tree().get_nodes_in_group("player")
      if player_node.size() >0:
            if player_node[0] != null:
                  var player  = player_node[0] as Node2D
                  target_position = player.global_position

