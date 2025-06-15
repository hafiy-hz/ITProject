extends CanvasLayer

@onready var boss_ui: Control = $Control/BossUI
@onready var boss_hp_bar: TextureProgressBar = $Control/BossUI/TextureProgressBar
@onready var boss_label: Label = $Control/BossUI/Label

@export var button_focus_audio : AudioStream = preload( "res://Sounds/menu_focus.wav" )
@export var button_select_audio : AudioStream = preload( "res://Sounds/menu_select.wav" )

var hearts : Array[ HeartGUI ] = []

@onready var game_over : Control = $Control/GameOver
@onready var continue_button : Button = $Control/GameOver/VBoxContainer/ContinueButton
@onready var title_button : Button = $Control/GameOver/VBoxContainer/TittleButton
@onready var animation_player : AnimationPlayer = $Control/GameOver/AnimationPlayer
@onready var audio : AudioStreamPlayer = $AudioStreamPlayer

func _ready():
	for child in $Control/HFlowContainer.get_children():
		if child is HeartGUI:
			hearts.append( child )
			child.visible = false
	print("HeartGUI nodes found: ", hearts.size())
	
	hide_boss_health()
	
	hide_game_over_screen()
	continue_button.focus_entered.connect( play_audio.bind( button_focus_audio ) )
	continue_button.pressed.connect( load_game )
	title_button.focus_entered.connect( play_audio.bind( button_focus_audio ) )
	title_button.pressed.connect( title_screen )
	LevelManagers.level_load_started.connect( hide_game_over_screen )
	
	pass

func update_hp( _hp: int, _max_hp: int) -> void:
	update_max_hp( _max_hp)
	for i in _max_hp:
		update_heart( i, _hp )
		pass
	pass

func update_heart( _index : int, _hp : int) -> void:
	if _index >= 0 and _index < hearts.size():
		var _value : int = clampi( _hp - _index * 2, 0, 2 )
		hearts[ _index ].value = _value
	pass

func update_max_hp( _max_hp : int ) -> void:
	var _heart_count : int = roundi( _max_hp * 0.5 )
	for i in hearts.size():
		if i < _heart_count:
			hearts[i].visible = true
		else:
			hearts[i].visible = false
	pass

func show_boss_health( boss_name : String ) -> void:
	boss_ui.visible = true
	boss_label.text = boss_name
	update_boss_health( 1, 1 )
	pass

func hide_boss_health() -> void:
	boss_ui.visible = false
	
	pass


func update_boss_health( hp : int, max_hp : int ) -> void:
	boss_hp_bar.value = clampf( float(hp) / float(max_hp) * 100, 0, 100 )
	pass


func show_game_over_screen(can_continue: bool) -> void:
	if not game_over or not continue_button or not title_button or not animation_player:
		return

	game_over.visible = true
	game_over.mouse_filter = Control.MOUSE_FILTER_STOP

	continue_button.visible = can_continue
	continue_button.disabled = false
	title_button.disabled = false

	if animation_player.has_animation("show_game_over"):
		animation_player.play("show_game_over")
		await animation_player.animation_finished

	if can_continue:
		continue_button.grab_focus()
	else:
		title_button.grab_focus()



func hide_game_over_screen() -> void:
	game_over.visible = false
	game_over.mouse_filter = Control.MOUSE_FILTER_IGNORE
	game_over.modulate = Color( 1,1,1,0 )

func load_game() -> void:
	play_audio( button_select_audio )
	get_tree().change_scene_to_file("res://stage/level_1.tscn")
	hide_game_over_screen()
	

func fade_to_black() -> bool:
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	PlayerManager.player.revive_player()
	return true

func title_screen() -> void:
	play_audio( button_select_audio )
	await fade_to_black()
	get_tree().quit()


func play_audio( _a : AudioStream ) -> void:
	audio.stream = _a
	audio.play()
	
