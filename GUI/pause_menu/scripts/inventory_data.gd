class_name InventoryData
extends Resource

@export var slots: Array[SlotData]

func _init() -> void:
	connect_slots()

# Add item to inventory
func add_item(item: ItemsData, count: int = 1) -> bool:
	# Try to stack item if already present
	for s in slots:
		if s and s.item_data == item:
			s.quantity += count
			return true

	# Add to empty slot
	for i in slots.size():
		if slots[i] == null:
			var new_slot = SlotData.new()
			new_slot.item_data = item
			new_slot.quantity = count
			slots[i] = new_slot
			new_slot.changed.connect(slot_changed)
			return true

	print("Inventory is full!")
	return false

# Remove empty slots and notify UI
func slot_changed() -> void:
	for s in slots:
		if s and s.quantity < 1:
			s.changed.disconnect(slot_changed)
			var index = slots.find(s)
			slots[index] = null
			emit_changed()

# Reconnect signals
func connect_slots() -> void:
	for s in slots:
		if s:
			s.changed.connect(slot_changed)

# Utility: Get all current slots (including empty if needed)
func get_all_items() -> Array[SlotData]:
	return slots

# Save the inventory to an array of dictionaries
func get_save_data() -> Array:
	var item_save: Array = []
	for i in slots.size():
		item_save.append(item_to_saved(slots[i]))
	return item_save

# Turn one slot into a saveable dictionary
func item_to_saved(slot: SlotData) -> Dictionary:
	var result = { "item": "", "quantity": 0 }
	if slot != null:
		result.quantity = slot.quantity
		if slot.item_data != null:
			result.item = slot.item_data.resource_path
	return result

# Load save data into inventory
func parse_save_data(save_data: Array) -> void:
	var array_size = slots.size()
	slots.clear()
	slots.resize(array_size)
	for i in save_data.size():
		slots[i] = item_from_save(save_data[i])
	connect_slots()

# Convert saved dictionary back into a slot
func item_from_save(save_object: Dictionary) -> SlotData:
	if save_object.item == "":
		return null
	var new_slot: SlotData = SlotData.new()
	new_slot.item_data = load(save_object.item)
	new_slot.quantity = int(save_object.quantity)
	return new_slot
