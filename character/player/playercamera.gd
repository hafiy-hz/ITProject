class_name PlayerCamera extends Camera2D

#called when then node enter the scene tree for the first time
func _ready():
	LevelManagers.TileMapBoundsChanged.connect( UpdateLimits )
	UpdateLimits( LevelManagers.current_tilemap_bounds )
	




func UpdateLimits( bounds : Array [ Vector2 ]) -> void:
	if bounds == []:
		return
	limit_left = int( bounds[0].x )
	limit_top = int( bounds[0].y )
	limit_right = int( bounds[1].x )
	limit_bottom = int( bounds[1].y )
	
