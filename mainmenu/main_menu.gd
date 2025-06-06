extends Control

func _ready() -> void:
	scale = Vector2(0.5, 0.5)  # Counteracts scale 4
	 # Make sure we're not in game mode
	PlayerManager.is_in_game = false
	PlayerManager.player_spawn = false
   

func _on_startbutton_pressed() -> void:
	get_tree().change_scene_to_file("res://mainmenu/PlayerUsername.tscn")

func _on_options_button_pressed() -> void:
	get_tree().change_scene_to_file("res://mainmenu/options.tscn")

func _on_exitbutton_pressed() -> void:
	get_tree().quit()
	
func _process(delta):
	position += (get_global_mouse_position()*delta)-position
	

	
	


	
