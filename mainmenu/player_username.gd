extends Control

func _ready() -> void:
	scale = Vector2(0.5, 0.5)  # Counteracts scale 4


func _on_button_rapier_pressed() -> void:
	get_tree().change_scene_to_file("res://stage/level_2.tscn")
	pass # Replace with function body.


func _on_button_sword_pressed() -> void:
	get_tree().change_scene_to_file("res://stage/level_2.tscn")
	pass # Replace with function body.


func _on_button_great_sword_pressed() -> void:
	get_tree().change_scene_to_file("res://stage/level_2.tscn")
	pass # Replace with function body.


func _on_back_button_2_pressed() -> void:
	
	pass # Replace with function body.
