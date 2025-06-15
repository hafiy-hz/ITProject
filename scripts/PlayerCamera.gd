class_name PlayerCamera extends Camera2D

#var target

#func _ready():
    #if get_tree().current_scene.name.begins_with("Level_"):
        #enabled = true
        #make_current()
        #LevelManagers.TileMapBoundsChanged.connect(UpdateLimits)
        #UpdateLimits(LevelManagers.current_tilemap_bounds)
    
    #var target_path = "Sprite2D"  # <-- Add this line
    
    #if target_path != null and has_node(target_path):
        #target = get_node(target_path)
    #else:
        #enabled = false

#func _process(delta):
    #if target != null:
        #global_position = target.global_position


#func UpdateLimits( bounds : Array[ Vector2 ] ) -> void:
    #if bounds == []:
        #return
    #limit_left = int( bounds[0].x )
    #limit_top = int( bounds[0].y )
    #limit_right = int( bounds[1].x )
    #limit_bottom = int( bounds[1].y )
    #pass


@export var follow_speed: float = 5.0  # Adjust this value to control how quickly the camera follows
@export var camera_offset := Vector2.ZERO  # Optional offset from the player

func _ready():
    LevelManagers.TileMapBoundsChanged.connect(UpdateLimits)
    UpdateLimits(LevelManagers.current_tilemap_bounds)
    
    # Make sure we're the current camera
    make_current()

func _process(delta: float) -> void:
    var target = get_parent()
    if target:
        # Calculate the target position with offset
        var target_position = target.global_position + camera_offset
        
        # Smoothly interpolate camera position to target position
        global_position = global_position.lerp(target_position, follow_speed * delta)

func UpdateLimits(bounds: Array[Vector2]) -> void:
    if bounds == []:
        return
    limit_left = int(bounds[0].x)
    limit_top = int(bounds[0].y)
    limit_right = int(bounds[1].x)
    limit_bottom = int(bounds[1].y)
    pass
