extends Control

var scores = [
    { "name": "Alice", "time": 85.30 },
    { "name": "Bob", "time": 90.12 },
    { "name": "Charlie", "time": 105.67 },
    { "name": "Diana", "time": 120.00 },
]

func _ready():
    var player_time = float(Global.speedrun_time)
    var player_name = Global.username
    
    # Add player's new score
    scores.append({ "name": player_name, "time": player_time })
    
    # Sort scores by time (smallest first)
    scores.sort_custom(_sort_scores)
    
    # Keep only top 5
    scores = scores.slice(0, 5)
    
    # Display
    var vbox = $VBoxContainer
    # Clear previous entries
    for child in vbox.get_children():
        child.queue_free()
    
    for i in range(scores.size()):
        var entry = Label.new()
        entry.text = str(i + 1) + ". " + scores[i]["name"] + " - " + format_time(scores[i]["time"])
        vbox.add_child(entry)

func _sort_scores(a, b):
    return a["time"] < b["time"]

func format_time(t):
    var minutes = int(t / 60)
    var seconds = int(t) % 60
    var centiseconds = int((t - int(t)) * 100)
    return "%d:%02d.%02d" % [minutes, seconds, centiseconds]

func _on_ReturnButton_pressed():
    get_tree().change_scene_to_file("res://mainmenu/main_menu.tscn")
