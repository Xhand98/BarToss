extends Control

var savePath: String = "user://userdata.save"
@onready var animated_sprite_2d: AnimatedSprite2D = $World/CenterContainer/VBoxContainer/Spacebar/AnimatedSprite2D
@onready var audio_stream_player: AudioStreamPlayer = $World/CenterContainer/VBoxContainer/Spacebar/AnimatedSprite2D/AudioStreamPlayer
@onready var world: Control = $World
@onready var timer: Timer = $Timer
@onready var fire_song: AudioStreamPlayer = $fire_mode
@onready var background: TextureRect = $TextureRect
@onready var coin = $World/CenterContainer/Coin/AnimatedSprite2D

@export_file("*.tscn") var next_scene: String

var normal_texture = preload("res://assets/images/backgrounds/1.png")
var fire_texture = preload("res://assets/images/backgrounds/fire.png")

var shake_str := 0.0
var original_pos := Vector2.ZERO

const exp1 = preload("res://effects/Explosion/Explosion.tscn")

#const MENU: PackedScene = preload("res://scenes/StartMenu/StartMenu.tscn")

var presses: int = 0;
var best_presses: int = 0;
var last_press: int = 0
signal loaded
signal press_change;
var fire_mode: bool = false;

func _ready() -> void:
	randomize()
	background.texture = normal_texture
	load_data()
	print(presses)
	original_pos = world.position
	animated_sprite_2d.play("idle")
	emit_signal("press_change", presses, best_presses)


func save_data():
	var data = {
		"current_presses": presses,
		"best_presses": best_presses,
		"last_press": last_press
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
	if coin.flipping:
		return
	#if ((randi() % 3) == 1):
		#print("change")
		#last_press = presses
		#presses = 0
		#SceneManager.transition_to(next_scene)
		#save_data()
		#return;

	coin.flip_coin()
	var result = await coin.flipped
	
	print("Coin result:", result)
	print("Player choice:", GameState.coin_choice)

	if result == GameState.coin_choice:
		print("Correct!")
	else:
		print("Wrong!")
		game_over()
		return
	
	
	animated_sprite_2d.play("press")
	audio_stream_player.play()
	
	presses += 1;
	if (presses > best_presses):
		best_presses = presses;
	if (presses > 9 and !fire_mode):
		fire_mode = true;
		background.texture = fire_texture
		shake_str = 15.0
		spawn_flames()
		$Timer.start()
		fire_song.play()
		

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

func spawn_exp():
	var exp = exp1.instantiate()
	
	var viewport = get_viewport_rect().size
	exp.position = Vector2(
		randf_range(0, viewport.x),
		randf_range(0, viewport.y)
	)
	
	add_child(exp)
	
func _on_explosion_finished():
	if fire_mode:
		spawn_exp()


func _on_timer_timeout() -> void:
	if fire_mode:
		spawn_exp()


func _on_fire_mode_finished() -> void:
	fire_song.play()
	
func load_scene() -> void:
	await get_tree().process_frame
	loaded.emit()

func game_over() -> void:
	print("GAME OVER")

	last_press = presses
	presses = 0
	save_data()

	SceneManager.transition_to(next_scene)
