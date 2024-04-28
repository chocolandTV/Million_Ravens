extends CharacterBody2D

var on_target_pos : bool = false
var on_mouse_entered : bool = false
@onready var target_pos : Node2D = $Target_Pos


func _input(event):
      if event.is_action_pressed("attack") && on_mouse_entered:
            damage_effect_tutoravii()

func _on_hurtbox_component_mouse_exited():
      on_mouse_entered = true

func _on_hurtbox_component_mouse_entered():
      on_mouse_entered = false
func damage_effect_tutoravii():
      print("Damage Effect on Tutoravii")