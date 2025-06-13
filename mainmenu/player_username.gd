extends Control

@onready var username_input = $CanvasLayer/CenterContainer/VBoxContainer/UsernameInput

func _ready() -> void:
    scale = Vector2(0.5, 0.5)
    print("Username node:", username_input)  # Will print null if broken

func _on_back_button_2_pressed() -> void:
    get_tree().change_scene_to_file("res://mainmenu/main_menu.tscn")


# Called when Warrior is selected
func _on_texture_button_pressed() -> void:
    _attempt_start_game("Rapier")


# Called when Mage is selected
func _on_texture_button_2_pressed() -> void:
    _attempt_start_game("Sword")


# Called when Rogue is selected
func _on_texture_button_3_pressed() -> void:
    _attempt_start_game("Greatsword")


func _attempt_start_game(selected_class: String) -> void:
    var username = username_input.text.strip_edges()
    if username == "":
        print("Please enter a username before selecting a class.")
        return

    Global.username = username
    Global.player_class = selected_class

    print("Saved username:", Global.username)
    print("Selected class:", Global.player_class)

    get_tree().change_scene_to_file("res://game/main_game.tscn")  # replace with your actual scene


func _on_button_pressed() -> void:
    get_tree().change_scene_to_file("res://stage/level_2.tscn")  # Change scene here
