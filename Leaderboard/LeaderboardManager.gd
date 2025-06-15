extends Node

const FILE_PATH := "res://Leaderboard/LeaderboardManager.gd"
const MAX_ENTRIES := 5

var entries: Array = []

func _ready():
    load_leaderboard()

func add_entry(player_name: String, time: float) -> void:
    entries.append({ "name": player_name, "time": time })
    entries.sort_custom(func(a, b): return a["time"] < b["time"])
    entries = entries.slice(0, MAX_ENTRIES)
    save_leaderboard()

func save_leaderboard():
    var file = FileAccess.open(FILE_PATH, FileAccess.WRITE)
    file.store_string(JSON.stringify(entries))
    file.close()

func load_leaderboard():
    if not FileAccess.file_exists(FILE_PATH):
        entries = []
        return

    var file = FileAccess.open(FILE_PATH, FileAccess.READ)
    var data = file.get_as_text()
    var parsed = JSON.parse_string(data)
    entries = parsed if parsed is Array else []

func get_leaderboard() -> Array:
    return entries
