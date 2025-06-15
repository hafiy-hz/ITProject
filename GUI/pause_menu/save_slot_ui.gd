extends Control

signal save_slot_selected(slot_index: int)
signal load_slot_selected(slot_index: int)

@onready var grid_container: GridContainer = $PanelContainer/VBoxContainer/GridContainer
@onready var back_button: Button = $PanelContainer/VBoxContainer/BackButton
@onready var title_label: Label = $PanelContainer/VBoxContainer/Label

var save_mode: bool = false
var save_slots: Array[Button] = []

func _ready():
	setup_save_slots()
	back_button.pressed.connect(_on_back_pressed)

func setup_save_slots():
	# Create 6 save slots (2 rows of 3)
	for i in range(6):
		var slot_button = Button.new()
		slot_button.custom_minimum_size = Vector2(120, 80)
		slot_button.text = "SLOT %d" % (i + 1)
		slot_button.pressed.connect(_on_slot_pressed.bind(i))
		
		# Style the button
		var style_box = StyleBoxFlat.new()
		style_box.bg_color = Color(0.2, 0.2, 0.2, 0.8)
		style_box.border_width_left = 2
		style_box.border_width_right = 2
		style_box.border_width_top = 2
		style_box.border_width_bottom = 2
		style_box.border_color = Color(0.6, 0.6, 0.6, 1.0)
		style_box.corner_radius_top_left = 5
		style_box.corner_radius_top_right = 5
		style_box.corner_radius_bottom_left = 5
		style_box.corner_radius_bottom_right = 5
		
		slot_button.add_theme_stylebox_override("normal", style_box)
		
		grid_container.add_child(slot_button)
		save_slots.append(slot_button)
		
		# Load save data to display info
		update_slot_display(i)

func update_slot_display(slot_index: int):
	var slot_button = save_slots[slot_index]
	var save_path = "user://save_slot_%d.sav" % slot_index
	
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		if file:
			var json = JSON.new()
			var parse_result = json.parse(file.get_line())
			file.close()
			
			if parse_result == OK:
				var save_data = json.get_data() as Dictionary
				var level_name = save_data.get("scene_path", "").get_file().get_basename()
				var player_hp = save_data.get("player", {}).get("hp", 0)
				var max_hp = save_data.get("player", {}).get("max_hp", 0)
				
				slot_button.text = "SLOT %d\n%s\nHP: %d/%d" % [slot_index + 1, level_name, player_hp, max_hp]
			else:
				slot_button.text = "SLOT %d\n[CORRUPTED]" % (slot_index + 1)
	else:
		slot_button.text = "SLOT %d\n[EMPTY]" % (slot_index + 1)

func show_save_mode():
	save_mode = true
	title_label.text = "SELECT SAVE SLOT"
	visible = true
	# Refresh slot displays
	for i in range(save_slots.size()):
		update_slot_display(i)

func show_load_mode():
	save_mode = false
	title_label.text = "SELECT LOAD SLOT"
	visible = true
	# Refresh slot displays
	for i in range(save_slots.size()):
		update_slot_display(i)

func _on_slot_pressed(slot_index: int):
	if save_mode:
		save_slot_selected.emit(slot_index)
	else:
		# Check if slot has data before loading
		var save_path = "user://save_slot_%d.sav" % slot_index
		if FileAccess.file_exists(save_path):
			load_slot_selected.emit(slot_index)

func _on_back_pressed():
	visible = false 
