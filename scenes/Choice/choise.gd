extends Control

signal loaded

var choice: int;
@export_file("*.tscn") var next_scene: String

func load_scene() -> void:
	await get_tree().process_frame
	loaded.emit()


func _on_texture_button_button_down() -> void:
	GameState.coin_choice = 0;
	_change_scene()


func _on_texture_button_2_button_down() -> void:
	GameState.coin_choice = 1;
	_change_scene()
	
func _change_scene() -> void:
	SceneManager.transition_to(next_scene)
