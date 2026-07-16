extends Control

var savePath: String = "user://userdata.save"
@onready var animated_sprite_2d: AnimatedSprite2D = $World/CenterContainer/AnimatedSprite2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var world: Control = $World

var shake_str := 0.0
var original_pos := Vector2.ZERO

const exp1 = preload("res://effects/Explosion.tscn")

#const MENU: PackedScene = preload("res://scenes/StartMenu/StartMenu.tscn")

var presses: int = 0;
var best_presses: int = 0;
signal press_change;
var fire_mode: bool = false;

func _ready() -> void:
	load_data()
	print(presses)
	original_pos = world.position
	animated_sprite_2d.play("idle")
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
	
	if fire_mode:
		shake_str = 15.0
	else:
		shake_str = lerpf(shake_str, 0.0, delta * 8.0)
	
	if shake_str > 0:
		world.position = original_pos + Vector2(
			randf_range(-shake_str, shake_str),
			randf_range(-shake_str, shake_str)
		)
		
		
		if shake_str < 0.1:
			shake_str = 0
			world.position = original_pos


func _on_texture_button_button_down() -> void:
	if ((randi() % 3) == 1):
		print("change")
		presses = 0
		get_tree().change_scene_to_file("res://scenes/StartMenu/StartMenu_2.tscn");
		save_data()
		return;

	animated_sprite_2d.play("press")
	audio_stream_player.play()
	
	presses += 1;
	if (presses > best_presses):
		best_presses = presses;
	if (presses > 2 and !fire_mode):
		fire_mode = true;
		shake_str = 15.0
		spawn_flames()

	emit_signal("press_change", presses, best_presses)
	save_data()


func _on_animated_sprite_2d_animation_finished() -> void:
	if (animated_sprite_2d.animation == "press"):
		animated_sprite_2d.play("idle")
		
func spawn_flames() -> void:
	for i in range(15):
		var flame = exp1.instantiate()
		
		flame.position = Vector2(
			randf_range(0, 1152),
			randf_range(0, 648)
		)
		
		add_child(flame)
