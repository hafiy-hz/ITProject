extends Node2D

signal level_load_started
signal level_loaded 
signal TileMapBoundsChanged( bounds : Array[ Vector2 ] )

var current_tilemap_bounds : Array[ Vector2 ]
var target_transition : String
var position_offset : Vector2

func _ready() -> void:
    await get_tree().process_frame
    level_loaded.emit()
    self.y_sort_enabled = true 
    #PlayerManager.set_as_parent( self )
    LevelManagers.level_load_started.connect( _free_level )


func ChangeTilemapBounds( bounds : Array[ Vector2 ] ) -> void:
    current_tilemap_bounds = bounds
    TileMapBoundsChanged.emit( bounds )

func load_new_level(
        level_path: String,
        _target_transition: String,
        _position_offset: Vector2
) -> void:
    if level_path == "" or not ResourceLoader.exists(level_path):
        push_warning("Invalid or missing level path: " + str(level_path))
        return

    get_tree().paused = true
    target_transition = _target_transition
    position_offset = _position_offset

    await SceneTransition.fade_out()
    level_load_started.emit()

    var scene_resource = load(level_path)
    if scene_resource == null:
        push_warning("Failed to load scene from path: " + level_path)
        return

    var new_scene = scene_resource.instantiate()
    get_tree().get_root().add_child(new_scene)

    await SceneTransition.fade_in()
    get_tree().paused = false
    level_loaded.emit()
    

func _free_level() -> void:
    #PlayerManager.unparent_player( self )
    queue_free()
    
