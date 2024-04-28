extends Area2D
class_name Dash_Damage_Component

var damage = 4
@export var damage_type : int = 0
const BASEDAMAGE = 4


func apply_damage_bonus(enemy_damage_bonus):
     damage =enemy_damage_bonus

func on_upgrade_damage(quantity : float):
      damage = quantity * BASEDAMAGE