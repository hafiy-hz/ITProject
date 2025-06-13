extends CanvasLayer

@onready var username_label: Label = $"PlayerInfoContainer/UsernameLabel"
@onready var player_class_label: Label = $"PlayerInfoContainer/PlayerClassLabel"

func _ready():
	PlayerManager.player_info_updated.connect(update_player_info)
	update_player_info()

func update_player_info():
	if username_label != null:
		username_label.text = "Username: " + PlayerManager.player_username
	if player_class_label != null:
		player_class_label.text = "Class: " + PlayerManager.player_class.capitalize() + " (Damage: " + str(PlayerManager.player_damage) + ")" 
