extends Control

@onready var username_input = $CanvasLayer/CenterContainer/VBoxContainer/UsernameInput

func _ready() -> void:
	scale = Vector2(0.5, 0.5)  # Counteracts scale 4


func _on_button_rapier_pressed() -> void:
	var username = $PlayerClass/CenterContainer/VBoxContainer/LineEdit.text
	PlayerManager.player_username = username
	PlayerManager.player_class = "rapier"
	PlayerManager.player_damage = PlayerManager.class_damage["rapier"]
	PlayerManager.player_info_updated.emit()
	get_tree().change_scene_to_file("res://stage/level_1.tscn")


func _on_button_sword_pressed() -> void:
	var username = $PlayerClass/CenterContainer/VBoxContainer/LineEdit.text
	PlayerManager.player_username = username
	PlayerManager.player_class = "sword"
	PlayerManager.player_damage = PlayerManager.class_damage["sword"]
	PlayerManager.player_info_updated.emit()
	get_tree().change_scene_to_file("res://stage/level_1.tscn")


func _on_button_great_sword_pressed() -> void:

	var username = $PlayerClass/CenterContainer/VBoxContainer/LineEdit.text
	PlayerManager.player_username = username
	PlayerManager.player_class = "greatsword"
	PlayerManager.player_damage = PlayerManager.class_damage["greatsword"]
	PlayerManager.player_info_updated.emit()
	get_tree().change_scene_to_file("res://stage/level_3.tscn")



func _on_back_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://mainmenu/main_menu.tscn")
	


func _on_texture_button_pressed() -> void:
	pass # Replace with function body.


func _on_texture_button_2_pressed() -> void:
	pass # Replace with function body.


func _on_texture_button_3_pressed() -> void:
	pass # Replace with function body.
