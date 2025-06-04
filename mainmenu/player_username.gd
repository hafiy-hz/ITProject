extends Control

func _ready() -> void:
    scale = Vector2(0.25, 0.25)  # Counteracts scale 4

func _on_back_button_2_pressed() -> void:
    get_tree().change_scene_to_file("res://mainmenu/main_menu.tscn")
    


func _on_texture_button_pressed() -> void:
    pass # Replace with function body.


func _on_texture_button_2_pressed() -> void:
    pass # Replace with function body.


func _on_texture_button_3_pressed() -> void:
    pass # Replace with function body.
