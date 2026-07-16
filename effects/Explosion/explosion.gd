extends AnimatedSprite2D
@onready var animated_sprite_2d: AnimatedSprite2D = $"."

signal finished;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite_2d.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animation_finished() -> void:
	emit_signal("finished")
	queue_free()
