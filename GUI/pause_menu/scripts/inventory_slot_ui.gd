class_name InventorySlotUI
extends Button

var slot_data: SlotData : set = set_slot_data

@onready var texture_rect: TextureRect = $TextureRect
@onready var label: Label = $Label

func _ready() -> void:
    texture_rect.texture = null
    label.text = "" 
    focus_entered.connect(item_focused)
    focus_exited.connect(item_unfocused)
    pressed.connect(item_pressed)

func set_slot_data(value: SlotData) -> void:
    slot_data = value
    if slot_data == null or slot_data.item_data == null:
        texture_rect.texture = null
        label.text = ""
        return
    texture_rect.texture = slot_data.item_data.texture
    label.text = str(slot_data.quantity)


func item_focused() -> void:
    if slot_data and slot_data.item_data:
        PauseMenu.update_item_description(slot_data.item_data.description)

func item_unfocused() -> void:
    PauseMenu.update_item_description("")

func item_pressed() -> void:
    if not slot_data or not slot_data.item_data:
        return

    # Check if item is equipable
    if slot_data.item_data is EquipableItemData:
        var equipable_item := slot_data.item_data as EquipableItemData
        EquipableManager.equip(equipable_item)  # Equip the item
        print("Equipped:", equipable_item.name)

        # Optionally update player's stats (already done in EquipableManager)
        # Optionally update equipment UI
        if PauseMenu.equipment_panel and PauseMenu.equipment_panel.has_method("update_equipment"):
            PauseMenu.equipment_panel.update_equipment(EquipableManager.get_equipped_items())
    else:
        # Handle as consumable or normal item
        var was_used := slot_data.item_data.use()
        if was_used:
            slot_data.quantity -= 1
            label.text = str(slot_data.quantity)
