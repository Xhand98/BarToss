extends PanelContainer
const GAME: Resource = preload("res://scenes/Game/Game.tscn")

@onready var audio_stream_player: AudioStreamPlayer = $"../AudioStreamPlayer"

@onready var check_button: CheckButton = $VBoxContainer/CheckButton
var audio_muted: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_opt_btn_pressed() -> void:
	#get_tree().change_scene_to_packed(GAME);
	pass

func _on_texture_button_toggled(toggled_on: bool) -> void:
	audio_muted = toggled_on;
	
	AudioServer.set_bus_mute(0, audio_muted)
	if (audio_muted == true): 
		audio_stream_player.stream_paused = true;
	else:
		audio_stream_player.stream_paused = false


func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(GAME);


func _on_exit_pressed() -> void:
	#get_tree().finish
	pass
