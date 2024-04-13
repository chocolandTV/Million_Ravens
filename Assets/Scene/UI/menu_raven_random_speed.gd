extends AnimatedSprite2D

@export var min_position : float = -200
@export var max_position : float = 200
@export var floating_angle : float = 25

@export var timer_random_range :Vector2 = Vector2(0,20)
@onready var float_timer: Timer =$Timer

var target_position :Vector2 = Vector2.ZERO
var direction : bool = false
var base_height : float
func _ready():
      float_timer.timeout.connect(on_timer_timeout)
      base_height = self.global_position.y
func _process(delta):
      if is_visible_in_tree():
            floatingSprite(delta * 3.0)


func floatingSprite(_t :float):
      target_position.y = randf_range(base_height- floating_angle, base_height+ floating_angle)
      self.global_position = lerp(self.global_position, target_position, _t)


func on_timer_timeout():
      changeDirection(target_position)

func changeDirection(pos :Vector2):
      direction = !direction
      target_position = getNewTargetPosition()

func getNewTargetPosition():
      var _random_position: Vector2 
      if direction: # LEFT
            _random_position = Vector2(randf_range(min_position+100, 0),global_position.y)
      else: # RIGHT
            _random_position = Vector2(randf_range(0, max_position),global_position.y)
      float_timer.wait_time = randf_range(timer_random_range.x,timer_random_range.y)
      float_timer.start()
      return _random_position