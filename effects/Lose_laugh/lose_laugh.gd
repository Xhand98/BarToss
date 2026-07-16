extends Control

signal finished;



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _ready() -> void:
	await get_tree().create_timer(1.5).timeout
	emit_signal("finished")
	queue_free()
