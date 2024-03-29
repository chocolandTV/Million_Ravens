extends Area2D
class_name PlayerHurtboxComponent

@export var player_health_comonent : PlayerHealthComponent

func _ready():
	area_entered.connect(on_area_entered)

func on_area_entered(other_area :Area2D):
	if not other_area is HitboxComponent:
		
		return
	var hitbox_component = other_area as HitboxComponent
	# print("get damage: " + str(hitbox_component.damage))
	receive_damage(hitbox_component.damage)
	hitbox_component.knockback()

func receive_damage(damage : int):
	player_health_comonent.damage(damage)
