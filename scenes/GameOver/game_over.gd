extends Control

var savePath: String = "user://userdata.save"

var presses: int = 0;
var best_presses: int = 0;
var last_press:int = 0
@onready var hs_label: Label = $VBoxContainer3/HS_container/HS_label
@onready var s_label: Label = $VBoxContainer2/Label
@onready var sh_label: Label = $VBoxContainer3/S_container/S_label
@onready var timer: Timer = $Timer

@export_file("*.tscn") var next_scene: String

const exp1 = preload("res://effects/Lose_laugh/laugh.tscn")

signal loaded

func load_data():
	if (FileAccess.file_exists(savePath)):
		var file = FileAccess.open(savePath, FileAccess.READ)
		var data = file.get_var()
		file.close()
		if (typeof(data) == TYPE_DICTIONARY):
			presses = data.get("current_presses", 0)
			best_presses = data.get("best_presses", 0)
			last_press = data.get("last_press", 0)
		else:
			save_data()


func save_data():
	var data = {
		"current_presses": presses,
		"best_presses": best_presses,
		"last_score": last_press
	}
	var file = FileAccess.open(savePath, FileAccess.WRITE)
	file.store_var(data)
	file.close()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_data()
	spawn_flames()
	spawn_exp()
	
	print(DisplayServer.mouse_get_mode())
	sh_label.text = "Score: " + str(last_press)
	hs_label.text = "Record: " + str(best_presses)
	

func _process(delta: float) -> void:
	pass
	
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
	
	exp.finished.connect(_on_lose_laugh_finished)
	
	add_child(exp)
	
func _on_lose_laugh_finished():
		spawn_exp()


func _on_timer_timeout() -> void:
		spawn_exp()

func _on_texture_button_button_down() -> void:
	SceneManager.transition_to(next_scene)


func _on_texture_button_2_button_down() -> void:
	OS.shell_open("https://x.com/intent/tweet?text=I+just+got+this+score+on+this+luck-based+game%21+%5Bpaste+image+plz%5D&url=https%3A%2F%2Fxhand98.itch.io%2Fbartoss&hashtags=bartoss,xhand98,gamedev")


func _on_texture_button_mouse_entered() -> void:
	print("entered") # Replace with function body.

func load_scene() -> void:
	await get_tree().process_frame
	loaded.emit()
