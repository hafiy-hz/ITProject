extends Control

var hovering_item = false

func _ready():
    # Connect each slot's hover signals
    for slot in $ItemGrid.get_children():
        slot.mouse_entered.connect(_on_slot_mouse_entered.bind(slot))
        slot.mouse_exited.connect(_on_slot_mouse_exited.bind(slot))
        
        # Example: Assign some item data to the slot
        # You would normally set this based on your actual inventory
        slot.set_meta("item_data", {
            "name": "Sword of Light",
            "type": "Sword",
            "rarity": "Legendary",
            "power": 120
    
        })
    
    # Start with InfoPanel hidden
    $InfoPanel.visible = false

func _on_slot_mouse_entered(slot):
    print("Mouse entered slot")
    if slot.has_meta("item_data"):
        var item_data = slot.get_meta("item_data")
        if item_data:
            hovering_item = true
            $InfoPanel.visible = true
            
            # Format tooltip with all item properties
            var tooltip_text = ""
            tooltip_text += "Name: " + item_data["name"] + "\n"
            tooltip_text += "Type: " + item_data["type"] + "\n"
            tooltip_text += "Rarity: " + item_data["rarity"] + "\n"
            tooltip_text += "Power: " + str(item_data["power"])
            
            $InfoPanel/Infolabel.text = tooltip_text
    else:
        print("No item_data found on this slot")

func _on_slot_mouse_exited(_slot):
    print("Mouse exited slot")
    hovering_item = false
    $InfoPanel.visible = false

func _process(delta):
    # Update tooltip position when hovering over an item
    if hovering_item:
        var mouse_pos = get_viewport().get_mouse_position()
        var target_pos = mouse_pos + Vector2(20, 20)
        $InfoPanel.global_position = lerp($InfoPanel.global_position, target_pos, 10 * delta)
