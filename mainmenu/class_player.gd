extends CanvasLayer

func _ready():
	self.scale = Vector2(0.5, 0.5)  # Match project scale (if project scale is 4)
	
func on_rapier_button_pressed() -> void:
	get_tree().change_scene_to_file("res://stage/level_1.tscn")
	pass


func on_sword_button_pressed() -> void:
	get_tree().change_scene_to_file("res://stage/level_1.tscn")
	pass


func on_great_button_pressed() -> void:
	get_tree().change_scene_to_file("res://stage/level_3.tscn")
	pass
