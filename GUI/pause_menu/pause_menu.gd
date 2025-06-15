extends CanvasLayer

signal shown
signal hidden

@onready var audio_stream_player: AudioStreamPlayer = $Control/AudioStreamPlayer
@onready var button_save: Button = $Control/HBoxContainer/Button_Save
@onready var button_load: Button = $Control/HBoxContainer/Button_Load
@onready var item_description: Label = $Control/ItemDescription

# Inventory & Equipment panels
@onready var inventory_panel = $Control/PanelContainer  # Replace with actual node path to your InventoryPanel
@onready var equipment_panel = $Control/PanelContainer2  # Replace with actual node path to your EquipmentPanel


var is_paused : bool = false

func _ready() -> void:
    hide_paused_menu()
    button_save.pressed.connect(_on_save_pressed)
    button_load.pressed.connect(_on_load_pressed)

    # Optionally connect signals from inventory_panel if it emits item_hovered
    if inventory_panel.has_signal("item_hovered"):
        inventory_panel.item_hovered.connect(update_item_description)

func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("pause"):
        if not is_paused:
            show_pause_menu()
        else:
            hide_paused_menu()
        get_viewport().set_input_as_handled()

func show_pause_menu() -> void:
    get_tree().paused = true
    visible = true
    is_paused = true
    shown.emit()

    # Update inventory and equipment panels
    if inventory_panel and inventory_panel.has_method("update_inventory"):
        inventory_panel.update_inventory(PlayerManager.INVENTORY_DATA.get_all_items())

    if equipment_panel and equipment_panel.has_method("update_equipment"):
        equipment_panel.update_equipment(EquipableManager.get_equipped_items())

func hide_paused_menu() -> void:
    get_tree().paused = false
    visible = false
    is_paused = false
    hidden.emit()

func _on_save_pressed() -> void:
    if not is_paused:
        return
    SaveManager.save_game()
    hide_paused_menu()

func _on_load_pressed() -> void:
    if not is_paused:
        return
    SaveManager.load_game()
    await LevelManagers.level_load_started
    hide_paused_menu()

func update_item_description(new_text: String) -> void:
    item_description.text = new_text

func play_audio(audio: AudioStream) -> void:
    audio_stream_player.stream = audio
    audio_stream_player.play()
