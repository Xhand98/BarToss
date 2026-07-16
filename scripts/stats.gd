extends VBoxContainer

@onready var v_box_container: VBoxContainer = $"."
@onready var label: Label = $Label

func _on_control_press_change(amount, best_amount) -> void:
	label.text = "Presses: " +  str(amount) + " | " + "Record: " + str(best_amount)
	# Presses: 0 | Best Presses: 0 
	
