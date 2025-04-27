extends Control

func _unhandled_input(event):
    if event.is_pressed():
        get_tree().change_scene_to_file("res://mainMenu/main_menu.tscn")
