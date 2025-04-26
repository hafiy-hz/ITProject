extends Control


func _on_startbutton_pressed() -> void:
	get_tree().change_scene_to_file("res://PlayerUsername.tscn")


func _on_options_button_pressed() -> void:
	get_tree().change_scene_to_file("res://mainmenu/options.tscn")# Replace with function body.


func _on_exitbutton_pressed() -> void:
	get_tree().quit() # Replace with function body.
	
