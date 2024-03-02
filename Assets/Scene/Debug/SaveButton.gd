extends Button
@onready var filemanager : Filemanager = get_node("/root/GlobalFileManager")

func _on_pressed():
      filemanager.save_game()
