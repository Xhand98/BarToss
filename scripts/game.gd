extends Control

#const MENU: PackedScene = preload("res://scenes/StartMenu/StartMenu.tscn")

var presses: int = 0;
signal press_change;

func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("Press")):
		_on_texture_button_button_down()


func _on_texture_button_button_down() -> void:
	#get_tree().change_scene_to_fil	e("res://scenes/StartMenu/StartMenu.tscn");
	if ((randi() % 3) == 1):
		print("change")
		get_tree().change_scene_to_file("res://scenes/StartMenu/StartMenu.tscn");

	presses += 1;
	emit_signal("press_change", presses)
