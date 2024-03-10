extends Area2D
class_name HitboxComponent

var damage = 5

@export var damage_source : Enemy01_Ravii

func knockback()-> void :
     
     damage_source.knockbackEffect()