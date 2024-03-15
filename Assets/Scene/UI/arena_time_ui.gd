extends CanvasLayer

class_name ArenaDeltaTimer

@export var arena_time_manager: Node
@onready var label = $%Label
var timestart = 0
var time = 0
var timer_on = false
var text : String
func _ready():
      timer_on = true
      timestart =  Time.get_ticks_msec()

func _process(_delta):
      if get_parent().isGameStatePaused():
            return
      if arena_time_manager == null:
            return
      if(!timer_on):
            return
      time = Time.get_ticks_msec()- timestart
      #millseconds calculated: time mod 1000
      var msec = time%1000
      # ZwischenStep #01 convert time seconds : time /1000 int
      time = time / 1000
      # sekunden ausrechnen  time mod 60
      var secs = time%60
      # Zwischenstep 02 convert time minutes :  time / 60 int
      time = time /60
      #minuten ausrechnen time mod 60 
      var mins = time%60
      # Zwischenstep 03 convert time hours:  time / 60 int
      time = time /60
      #stunden ausrechnen time mod 24
      var hr = time%24
      # Zwischenstep 04 convert time days:  time / 24 int
      time = time /24
      #tage ausrechnen  time
      
      text = "Time : %02d :%02d : %02d : %02d : %03d" % [time,hr,mins,secs,msec]
      label.text = text