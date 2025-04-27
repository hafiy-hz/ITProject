extends Control


func _on_back_button_pressed() -> void:
    get_tree().change_scene_to_file("res://mainmenu/main_menu.tscn")


func _on_h_slider_value_changed(value: float) -> void:
       AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))

func _on_check_button_toggled(button_pressed: bool):
    if button_pressed:
        DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
    else:
        DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED) 
