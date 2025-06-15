class_name InventoryUI extends Control


const INVENTORY_SLOT = preload("res://GUI/pause_menu/inventory/inventory_slot.tscn")

var focus_index: int = 0

@export var data: InventoryData

func _ready() -> void:
    PauseMenu.shown.connect( update_inventory )
    PauseMenu.hidden.connect( clear_inventory )
    clear_inventory()
    data.changed.connect( on_inventory_changed )
    pass

    if data != null:
        data.changed.connect(on_inventory_changed)
    else:
        push_error("InventoryUI: Inventory data is null. Cannot connect 'changed' signal.")

func clear_inventory() -> void:
    for c in get_children():
        c.queue_free()

func update_inventory() -> void:
    for s in data.slots:
        var new_slot = INVENTORY_SLOT.instantiate()
        add_child( new_slot )
        new_slot.slot_data = s
        new_slot.focus_entered.connect( item_focused )
    
    # Only try to grab focus if we have children
    if get_child_count() > 0:
        get_child( 0 ).grab_focus()

func item_focused() -> void:
    for i in get_child_count():
        if get_child( i ).has_focus():
            focus_index = i # Fixed: was missing assignment operator
            break # Added break to exit loop once found
            


func on_inventory_changed() -> void:
    var _i = focus_index
    clear_inventory()
    update_inventory()
    await get_tree().process_frame
    # Only grab focus if we have children and focus_index is valid
    if get_child_count() > focus_index and focus_index >= 0:
        get_child( focus_index ).grab_focus()
