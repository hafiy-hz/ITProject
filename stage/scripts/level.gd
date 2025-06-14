class_name GameLevel extends Node2D

func _ready() -> void:
    self.y_sort_enabled = true 
    PlayerManager.set_as_parent( self )
    LevelManagers.level_load_started.connect( _free_level )


func _free_level() -> void:
    PlayerManager.unparent_player( self )
    queue_free()
    
