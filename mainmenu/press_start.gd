extends Control

@onready var transition = $CanvasLayer2/Transition  # AnimationPlayer node
@onready var fade_rect = $FadeRect    # ColorRect node
var has_started = false
var main_menu = preload("res://mainmenu/main_menu.tscn")

func _ready():
    scale = Vector2(0.5, 0.5)  # Counteracts scale 4
    # Play fade-in animation when scene starts
    $CanvasLayer2/Transition.play("fade_in")

# This handles any input (mouse click, key press, etc.)
func _unhandled_input(event):
    if event.is_pressed() and not has_started:
        has_started = true
    $CanvasLayer2/Transition.play("fade_out")  # Play fade-out animation


func _process(delta):
    position += (get_global_mouse_position()*delta)-position
    
    
func _on_transition_animation_finished(anim_name: StringName) -> void:
    if anim_name == "fade_out":
        # After fade-out is complete, change to the main menu scene
        get_tree().change_scene_to_file("res://mainmenu/main_menu.tscn")
