class_name InventoryUI extends Control


const INVENTORY_SLOT = preload("res://GUI/pause_menu/inventory/inventory_slot.tscn")

var focus_index: int = 0

@export var data: InventoryData

func _ready() -> void:
	PauseMenu.shown.connect(update_inventory)
	PauseMenu.hidden.connect(clear_inventory)
	clear_inventory()
	data.changed.connect( on_inventory_changed )

	

func clear_inventory() -> void:
	for c in get_children():
		c.queue_free()

func update_inventory() -> void:
	for s in data.slots:
		var new_slot = INVENTORY_SLOT.instantiate()
		add_child(new_slot)
		new_slot.slot_data = s
		new_slot.focus_entered.connect( item_focused )

	get_child( 0 ).grab_focus()

func item_focused() -> void:
	for i in get_child_count():
		if get_child( i ).has_focus():
			focus_index = i # Fixed: was missing assignment operator
			break # Added break to exit loop once found
			


func on_inventory_changed() -> void:
	clear_inventory()
	update_inventory()
	get_child( focus_index ).grab_focus()
	#await get_tree().process_frame
