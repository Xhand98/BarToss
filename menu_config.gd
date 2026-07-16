extends Resource
class_name MenuConfigResource

@export var menu_parent: NodePath
@export var default_button: NodePath
@export var button_parents: Array[NodePath]
@export var anim_player: NodePath
@export var show_anim: String
@export var hide_anim: String



@export var popup_menus: Array[MenuConfigResource]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
