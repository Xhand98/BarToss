extends Control

var choice: int;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


func _on_texture_button_button_down() -> void:
	choice = 0;


func _on_texture_button_2_button_down() -> void:
	choice = 1;
