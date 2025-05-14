extends Control

@onready var transition = $Transition

func _ready() -> void:
    $Transition.play("fade_in")

func _on_startbutton_pressed() -> void:
    # Play transition animation
    $Transition.play("fade_out")
    # Wait for animation to finish before changing scenes
    await $Transition.animation_finished
    # Then change the scene
    get_tree().change_scene_to_file("res://mainmenu/PlayerUsername.tscn")

func _on_options_button_pressed() -> void:
    # Play transition animation
    $Transition.play("fade_out")
    # Wait for animation to finish before changing scenes
    await $Transition.animation_finished
    # Then change the scene
    get_tree().change_scene_to_file("res://mainmenu/options.tscn")

func _on_exitbutton_pressed() -> void:
    # Play transition animation
    $Transition.play("fade_out")
    # Wait for animation to finish before quitting
    await $Transition.animation_finished
    # Then quit the game
    get_tree().quit()
    
func _process(delta):
    position += (get_global_mouse_position()*delta)-position
    
