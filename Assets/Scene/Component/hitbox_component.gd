extends Area2D
class_name HitboxComponent

@export var damage = 1
@export var damage_type : int = 0
signal raven_01_kockback


func knockback() :
     
     raven_01_kockback.emit()

func apply_damage_bonus(enemy_damage_bonus):
     damage +=enemy_damage_bonus