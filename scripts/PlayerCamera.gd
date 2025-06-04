class_name PlayerCamera
extends Camera2D

func _ready():
    if get_tree().current_scene.name == "Level1":  # Or your actual gameplay scene name
        enabled = true
        LevelManagers.TileMapBoundsChanged.connect(UpdateLimits)
        UpdateLimits(LevelManagers.current_tilemap_bounds)
    else:
        enabled = false

func UpdateLimits(bounds: Array[Vector2]) -> void:
    if bounds.is_empty():
        return
    limit_left = int(bounds[0].x)
    limit_top = int(bounds[0].y)
    limit_right = int(bounds[1].x)
    limit_bottom = int(bounds[1].y)
