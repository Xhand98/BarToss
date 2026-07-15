extends Control

var savePath: String = "user://userdata.save"

#const MENU: PackedScene = preload("res://scenes/StartMenu/StartMenu.tscn")

var presses: int = 0;
var best_presses: int = 0;
signal press_change;

func _ready() -> void:
	load_data()
	print(presses)
	emit_signal("press_change", presses, best_presses)


func save_data():
	var data = {
		"current_presses": presses,
		"best_presses": best_presses
	}
	var file = FileAccess.open(savePath, FileAccess.WRITE)
	file.store_var(data)
	file.close()

func load_data():
	if (FileAccess.file_exists(savePath)):
		var file = FileAccess.open(savePath, FileAccess.READ)
		var data = file.get_var()
		file.close()
		
		if (typeof(data) == TYPE_DICTIONARY):
			presses = data.get("current_presses", 0)
			best_presses = data.get("best_presses", 0)
		else:
			save_data()

func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("Press")):
		_on_texture_button_button_down()


func _on_texture_button_button_down() -> void:
	if ((randi() % 3) == 1):
		print("change")
		presses = 0
		get_tree().change_scene_to_file("res://scenes/StartMenu/StartMenu.tscn");

	presses += 1;
	if (presses > best_presses):
		best_presses = presses;

	emit_signal("press_change", presses, best_presses)
	save_data()
