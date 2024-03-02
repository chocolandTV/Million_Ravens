extends Label

@export var ostimer: Label
@export var deltatimer : Label




func _process(_delta):
      text  = "Difference : " + str((deltatimer.time*1000) - ostimer.debugTimer)


