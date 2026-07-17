extends CanvasLayer

signal transitioned_in()
signal transitioned_out()

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var margin_container: MarginContainer = $MarginContainer

func transition_in() -> void:
	animation_player.play("in")
	
func transition_out() -> void:
	print("out")
	create_tween().tween_property(margin_container, "scale", Vector2.ZERO, 0.3)
	animation_player.play("out")

func transition_to(scene: String) -> void:
	transition_in()
	await transitioned_in
	
	var new_scene = load(scene).instantiate()
	var root: Window = get_tree().get_root()
	
	#root.get_child(root.get_child_count() - 1).free()
	var current = get_tree().current_scene
	current.queue_free()
	
	root.add_child(new_scene)
	get_tree().current_scene = new_scene
	
	new_scene.load_scene()
	print(get_tree().current_scene)
	print(root.get_children())
	print("cargo, esperando pa await")
	await new_scene.loaded
	print("awaited")
	
	transition_out()
	await transitioned_out
	print("transition finished")
	
	#new_scene.activate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	#if (anim_name == "pulse"):
		#animation_player.play("pulse text")
		#transitioned_in.emit()
	#elif (anim_name == "out"):
		#transitioned_out.emit()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	print("Animation finished:", anim_name)

	if anim_name == "in":
		print("transitioned_in")
		animation_player.play("pulse text")
		transitioned_in.emit()

	elif anim_name == "out":
		print("transitioned_out")
		transitioned_out.emit()
