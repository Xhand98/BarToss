extends PanelContainer
const GAME: Resource = preload("res://scenes/Game.tscn")


@onready var check_button: CheckButton = $VBoxContainer/CheckButton
var audio_enabled: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(GAME);


func _on_opt_btn_pressed() -> void:
	#get_tree().change_scene_to_packed(GAME);
	pass


func _on_check_button_toggled(toggled_on: bool) -> void:
	audio_enabled = toggled_on;
	AudioServer.set_bus_mute(0, not audio_enabled)
	#Change icon to muted / unmuted
