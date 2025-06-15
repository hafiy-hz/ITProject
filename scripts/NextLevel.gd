extends Area2D

const FILE_BEGIN = "res://stage/level_"

func _on_body_entered(body: Node2D) -> void:
    if body.is_in_group("Player"):
        print( "colided with player")
        var current_scene_file = get_tree().current_scene.scene_file_path
        print( current_scene_file)
        var next_level_number = current_scene_file.to_int() + 1
        
        var next_level_path = FILE_BEGIN + str(next_level_number) + ".tscn"
        get_tree().change_scene_to_file(next_level_path)
    
