extends Area2D
class_name HitboxComponent

var damage = 5
signal raven_01_kockback


func knockback() :
     
     raven_01_kockback.emit()