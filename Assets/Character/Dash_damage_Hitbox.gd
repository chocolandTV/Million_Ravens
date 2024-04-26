extends Area2D
class_name Dash_Damage_Component

@export var damage = 1
@export var damage_type : int = 0
const BASEDAMAGE = 1

signal raven_01_kockback

func knockback() :

     raven_01_kockback.emit()

func apply_damage_bonus(enemy_damage_bonus):
     damage =enemy_damage_bonus

func on_upgrade_damage(quantity : float):
      damage = quantity * BASEDAMAGE