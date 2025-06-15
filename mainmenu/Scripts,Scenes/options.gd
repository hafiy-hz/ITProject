extends Control

var waiting_for_key = false
var current_action = ""
var button_to_update : Button = null

    
func _ready() -> void:
    scale = Vector2(0.5, 0.5)  # Counteracts scale 4
    $CanvasLayer/HBoxContainer/Fullscreen.focus_mode = Control.FOCUS_NONE  # Replace with actual node path

    var actions = ["move_left", "move_right", "move_up", "move_down"]
    for action in actions:
        add_keybind_row(action)

func _on_back_button_pressed() -> void:
    get_tree().change_scene_to_file("res://mainmenu/Scripts,Scenes/main_menu.tscn")

func _on_h_slider_value_changed(value: float) -> void:
    AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))

func _on_fullscreen_toggled(toggled_on: bool) -> void:
    if toggled_on:
        DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
    else:
        DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func add_keybind_row(action_name: String):
    var row = HBoxContainer.new()

    var label = Label.new()
    label.text = action_name.capitalize()
    label.size_flags_horizontal = Control.SIZE_EXPAND_FILL

    var key_button = Button.new()
    key_button.text = get_key_name_for_action(action_name)
    key_button.custom_minimum_size = Vector2(120, 0)
    key_button.size_flags_horizontal = Control.SIZE_FILL
    key_button.connect("pressed", Callable(self, "_on_keybind_button_pressed").bind(action_name, key_button))
    
    row.add_child(label)
    row.add_child(key_button)

    $CanvasLayer/Keybinds/Panel/ScrollContainer/VBoxContainer.add_child(row)

func get_key_name_for_action(action_name: String) -> String:
    var events = InputMap.action_get_events(action_name)
    if events.size() > 0 and events[0] is InputEventKey:
        return OS.get_keycode_string(events[0].physical_keycode)
    return "Unbound"

func _on_keybind_button_pressed(action: String, button: Button):
    current_action = action
    button_to_update = button
    button.text = "Press any key..."
    waiting_for_key = true

func _input(event):
    if waiting_for_key and event is InputEventKey and event.pressed:
        InputMap.action_erase_events(current_action)
        InputMap.action_add_event(current_action, event)
        button_to_update.text = OS.get_keycode_string(event.physical_keycode)
        waiting_for_key = false
        current_action = ""
        button_to_update = null


func scroll_up():
    $CanvasLayer/Keybinds/Panel/ScrollContainer.scroll_vertical -= 20

func scroll_down():
    $CanvasLayer/Keybinds/Panel/ScrollContainer.scroll_vertical += 20
    
func _process(delta):
    position += (get_global_mouse_position()*delta)-position
    
