extends Button

@export var slot_type := "helmet"  # or "armor", "weapon"
var equipped_item = null

func can_drop_data(position, data):
    return data != null and data.item_type == slot_type

func drop_data(position, data):
    if data == null:
        return

    equipped_item = data
    icon = data.texture  # Set the button icon to item texture

    update_stats(data)

func update_stats(item):
    var stats_panel = get_tree().get_root().find_node("StatsPanel", true, false)
    if stats_panel:
        stats_panel.update_stats(item)
