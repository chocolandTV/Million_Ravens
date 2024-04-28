extends CanvasLayer

class_name ArenaDeltaTimer

@export var _arena_time_manager: Node
@onready var label = $%Label
var timestart = 0
var time : int = 0
var timer_on = false
var text : String
func _ready():
      timer_on = true
      timestart =  Time.get_ticks_msec()

func get_formated_time_elapsed():
      return get_string_elapsed_time(time)
      
func get_string_elapsed_time(_time : int):
      #millseconds calculated: time mod 1000
      var msec = _time%1000
      # ZwischenStep #01 convert time seconds : time /1000 int
      @warning_ignore("integer_division")
      _time = _time / 1000
      # sekunden ausrechnen  time mod 60
      var secs = _time%60
      # Zwischenstep 02 convert time minutes :  time / 60 int
      @warning_ignore("integer_division")
      _time = _time /60
      #minuten ausrechnen time mod 60 
      var mins = _time%60
      # Zwischenstep 03 convert time hours:  time / 60 int
      @warning_ignore("integer_division")
      _time = _time /60
      #stunden ausrechnen time mod 24
      var hr = _time%24
      # Zwischenstep 04 convert time days:  time / 24 int
      return "Time : %02d : %02d : %02d : %03d" % [hr,mins,secs,msec]
func _process(_delta):
      if get_parent().isGameStatePaused():
            return
      if _arena_time_manager == null:
            return
      if(!timer_on):
            return
      time = Time.get_ticks_msec()- timestart
      label.text = get_string_elapsed_time(time)