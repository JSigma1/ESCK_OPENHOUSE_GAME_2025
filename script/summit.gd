extends Control

const FILE_PATH := "user://data/player_data.json"  
const SAVE_DIR  := "user://data"

@onready var label: Label = $VBoxContainer/Label
@onready var label_2: Label = $VBoxContainer/Label2
@onready var label_3: Label = $VBoxContainer/Label3
@onready var label_4: Label = $VBoxContainer/Label4
@onready var label_5: Label = $VBoxContainer/Label5
@onready var your_score: Label = $your_score

var play_time : float = 0.0

func _ready() -> void:
	$".".visible = false
	DirAccess.make_dir_recursive_absolute(SAVE_DIR)
	

func add_data(name: String, time_sec: float) -> void:
	var leaderboard: Array = _read_raw()

	var idx := -1
	for i in leaderboard.size():
		if str(leaderboard[i].get("player_name", "")).to_lower() == name.to_lower():
			idx = i
			break

	if idx >= 0:
		var old_time := float(leaderboard[idx].get("time_used", INF))
		if time_sec < old_time:
			leaderboard[idx]["time_used"] = time_sec
			leaderboard[idx]["date"] = Time.get_datetime_string_from_system(false)
	else:
		leaderboard.append({
			"player_name": name,
			"time_used": time_sec,
			"date": Time.get_datetime_string_from_system(false)
		})


	leaderboard.sort_custom(func(a, b):
		return float(a.get("time_used", INF)) < float(b.get("time_used", INF))
	)

	_write_raw(leaderboard)	

	
func read_leaderboard_sorted(limit: int = -1) -> Array:
	var lb := _read_raw()
	lb.sort_custom(func(a, b):
		return float(a.get("time_used", INF)) < float(b.get("time_used", INF))
	)
	return lb if limit <= 0 else lb.slice(0, min(limit, lb.size()))

func _read_raw() -> Array:
	var leaderboard: Array = []
	if FileAccess.file_exists(FILE_PATH):
		var f := FileAccess.open(FILE_PATH, FileAccess.READ)
		if f:
			var text := f.get_as_text()
			f.close()
			var parsed = JSON.parse_string(text)
			if typeof(parsed) == TYPE_ARRAY:
				leaderboard = parsed
	return leaderboard

func _write_raw(leaderboard: Array) -> void:
	var f := FileAccess.open(FILE_PATH, FileAccess.WRITE)
	if f:
		f.store_string(JSON.stringify(leaderboard, "\t"))
		f.close()
		print("save json at :",ProjectSettings.globalize_path(FILE_PATH))


func _on_control_call_leaderboard():
	$".".visible = true
	add_data(Dialogic.VAR.name, play_time)
	var current_player_name = Dialogic.VAR.name
	
	var top := read_leaderboard_sorted(5)
	if top.size() > 0:
		label.text   = "1) %s  %d second" % [top[0]["player_name"], int(top[0]["time_used"])]
	if top.size() > 1:
		label_2.text = "2) %s  %d second" % [top[1]["player_name"], int(top[1]["time_used"])]
	if top.size() > 2:
		label_3.text = "3) %s  %d second" % [top[2]["player_name"], int(top[2]["time_used"])]
	if top.size() > 3:
		label_4.text = "4) %s  %d second" % [top[3]["player_name"], int(top[3]["time_used"])]
	if top.size() > 4:
		label_5.text = "5) %s  %d second" % [top[4]["player_name"], int(top[4]["time_used"])]
		
	var all_data = read_leaderboard_sorted()
	for i in all_data.size():
		var entry = all_data[i]
		if str(entry["player_name"]).to_lower() == current_player_name.to_lower():
			var rank := i + 1
			your_score.text = "(Rank #%d) %s  %d second " % [
				rank,
				entry["player_name"],
				int(entry["time_used"])
			]
			break


func _on_button_pressed():
	get_tree().reload_current_scene()


func _on_game_elapesd_signal(time):
	play_time = time
