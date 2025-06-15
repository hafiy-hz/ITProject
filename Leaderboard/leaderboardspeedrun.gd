extends Control

var scores = []


func _sort_scores(a, b):
    return a["time"] < b["time"]

func format_time(t):
    var minutes = int(t / 60)
    var seconds = int(t) % 60
    var centiseconds = int((t - int(t)) * 100)
    return "%d:%02d.%02d" % [minutes, seconds, centiseconds]

func _ready():
    var player_time = float(Global.speedrun_time)
    var player_name = Global.username
    
    scores.append({ "name": player_name, "time": player_time })
    
    scores.sort_custom(_sort_scores)
    scores = scores.slice(0, 5)
    
    var vbox = $VBoxContainer
    for child in vbox.get_children():
        child.queue_free()
    
    for i in range(scores.size()):
        var entry = Label.new()
        entry.text = str(i + 1) + ". " + scores[i]["name"] + " - " + format_time(scores[i]["time"])
        vbox.add_child(entry)

func _on_texture_button_pressed() -> void:
    get_tree().change_scene_to_file("res://mainmenu/main_menu.tscn")
