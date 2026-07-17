extends Control
const GAME: String = "res://scenes/Game/Game.tscn"

@onready var audio_stream_player: AudioStreamPlayer = $"AudioStreamPlayer"

signal loaded()

@export_file("*.tscn") var next_scene: String

var audio_muted: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	loaded.emit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_opt_btn_pressed() -> void:
	#get_tree().change_scene_to_packed(GAME);
	pass

#func _on_texture_button_toggled(toggled_on: bool) -> void:
	


func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_play_pressed() -> void:
	SceneManager.transition_to(next_scene)
	#Transition.change_scene_to_file(GAME);
	#Transition.change_scene_to_file("res://scenes/GameOver/GameOver.tscn");
	pass

func _on_exit_pressed() -> void:
	get_tree().quit()
	pass

func load_scene() -> void:
	await get_tree().process_frame
	loaded.emit()


func _on_music_toggled(toggled_on: bool) -> void:
	audio_muted = toggled_on;
	
	AudioServer.set_bus_mute(0, audio_muted)
	if (audio_muted == true): 
		audio_stream_player.stream_paused = true;
	else:
		audio_stream_player.stream_paused = false
