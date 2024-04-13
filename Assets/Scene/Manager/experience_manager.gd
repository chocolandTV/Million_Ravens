extends Node
class_name ExperienceManager
@export var start_experience : float = 0
signal level_up(new_level: int)
signal experience_updated(current_experience : float, target_experience : float)
const TARGET_EXPERIENCE_GROWTH = 100
var current_experience = 0
var current_level  =1 
var target_experience = 100


# Called when the node enters the scene tree for the first time.
func _ready():
	GameEvents.highscore_orb_collected.connect(on_experience_orb_collected)
	if start_experience > 0:
		increment_experience(start_experience)

func increment_experience(number:float):
	current_experience += number
	if current_experience >= target_experience:
		current_level += 1
		target_experience += TARGET_EXPERIENCE_GROWTH
		level_up.emit(current_level)
		var temp_exp =  current_experience -target_experience
		current_experience  = 0
		increment_experience(temp_exp)

	experience_updated.emit(current_experience, target_experience)
func on_experience_orb_collected(number:float):
	increment_experience(number)


