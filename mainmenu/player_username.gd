extends Control

func _ready() -> void:
	scale = Vector2(0.5, 0.5)  # Counteracts scale 4


func _on_button_rapier_pressed() -> void:
	var username = $PlayerClass/CenterContainer/VBoxContainer/LineEdit.text
	PlayerManager.player_username = username
	PlayerManager.player_class = "rapier"
	PlayerManager.player_damage = PlayerManager.class_damage["rapier"]
	PlayerManager.player_info_updated.emit()
	get_tree().change_scene_to_file("res://stage/level_2.tscn")


func _on_button_sword_pressed() -> void:
	var username = $PlayerClass/CenterContainer/VBoxContainer/LineEdit.text
	PlayerManager.player_username = username
	PlayerManager.player_class = "sword"
	PlayerManager.player_damage = PlayerManager.class_damage["sword"]
	PlayerManager.player_info_updated.emit()
	get_tree().change_scene_to_file("res://stage/level_2.tscn")


func _on_button_great_sword_pressed() -> void:
	var username = $PlayerClass/CenterContainer/VBoxContainer/LineEdit.text
	PlayerManager.player_username = username
	PlayerManager.player_class = "greatsword"
	PlayerManager.player_damage = PlayerManager.class_damage["greatsword"]
	PlayerManager.player_info_updated.emit()
	get_tree().change_scene_to_file("res://stage/level_2.tscn")


func _on_back_button_2_pressed() -> void:
	
	pass # Replace with function body.
