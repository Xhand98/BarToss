extends VBoxContainer

@onready var v_box_container: VBoxContainer = $"."
@onready var label: Label = $Label

func _on_control_press_change(amount) -> void:
	label.text = "Presses: " +  str(amount)
	
