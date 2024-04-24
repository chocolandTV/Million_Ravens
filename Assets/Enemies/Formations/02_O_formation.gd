extends Node2D


func apply_bonus(enemy_damage_bonus : int, enemy_speed_bonus: int, enemy_health_bonus: int):
      for _i in self.get_children ():
            _i.apply_bonus(enemy_damage_bonus, enemy_speed_bonus, enemy_health_bonus)
