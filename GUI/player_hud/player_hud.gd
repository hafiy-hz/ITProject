extends CanvasLayer

@onready var boss_ui: Control = $Control/BossUI
@onready var boss_hp_bar: TextureProgressBar = $Control/BossUI/TextureProgressBar
@onready var boss_label: Label = $Control/BossUI/Label

var hearts : Array[ HeartGUI ] = []


func _ready():
    for child in $Control/HFlowContainer.get_children():
        if child is HeartGUI:
            hearts.append( child )
            child.visible = false
    print("HeartGUI nodes found: ", hearts.size())
    
    hide_boss_health()
    
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
