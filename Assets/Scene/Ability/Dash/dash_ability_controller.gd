extends Node


@onready var timer :Timer = $Timer
@onready var parent : CharacterBody2D = get_parent()
@export var dashDamageComponent : Dash_Damage_Component
var isCooldown :bool = false

func _ready():
      timer.timeout.connect(on_timer_timeout)
      GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)

func _input(event):
      if event.is_action_pressed("dash"):
            dashing()

func on_timer_timeout():
      isCooldown = false

func dashing():
      if isCooldown:
            return
      isCooldown =true
      timer.start()
      parent.player_dash()
      #animate


func on_ability_upgrade_added(upgrade : AbilityUpgrade, current_upgrades: Dictionary):
      if upgrade.id == "paw_attack_damage":
            dashDamageComponent.on_upgrade_damage(current_upgrades["paw_attack_damage"]["quantity"])

      if upgrade.id == "attack_speed":
             on_upgrade_cooldown(current_upgrades["attack_speed"]["quantity"])

func on_upgrade_cooldown(quantity : float):
      var percent_reduction = quantity* .1

      if percent_reduction > 0.99:
            percent_reduction = 0.99
      timer.wait_time = (1- percent_reduction)
      timer.start()