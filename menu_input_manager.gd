extends Node
class_name MenuInputManager

@export var base_menu: MenuConfigResource
@export var popup_menus: Array[MenuConfigResource]

var popup_menu_stack: Array

var cur_default_button: NodePath
var last_hovered_node: Control

enum ControlType { FocusInput, HoverInput }
var last_control_type: ControlType = ControlType.HoverInput

func _ready() -> void:
	cur_default_button = base_menu.default_button
	_setup_nodes_and_buttons(get_node(base_menu.menu_parent), true)
	for menu in popup_menus:
		_setup_nodes_and_buttons(get_node(menu.menu_parent), false)
	
func _setup_nodes_and_buttons(node: Control, is_base_menu: bool) -> void:
	if (!_is_hover_focusable(node)): 
		node.mouse_filter = Control.MOUSE_FILTER_IGNORE
	else: 
		if not node.mouse_entered.is_connected(_on_menubtn_hovered):
			node.connect("mouse_entered", _on_menubtn_hovered.bind(node))
		if !is_base_menu:
			node.mouse_filter = Control.MOUSE_FILTER_IGNORE
			node.focus_mode = Control.FOCUS_NONE
	for child in node.get_children():
		if child is Control:
			_setup_nodes_and_buttons(child, is_base_menu)

func _is_hover_focusable(node:Control) -> bool:
	return node is BaseButton or node is Range or node is ItemList or node is Tree or node is TextEdit or node is LineEdit
	
func _on_menubtn_hovered(menubutton: Control) -> void:
	if (menubutton.mouse_filter == Control.MOUSE_FILTER_STOP):
		last_hovered_node = menubutton
	else:
		pass
		
func _enable_disable_menu(menu: Array[NodePath], enable: bool) -> void:
	for path in menu:
		for node in get_node(path).get_children():
			if _is_hover_focusable(node):
				node.focus_mode = Control.FOCUS_ALL if enable else Control.FOCUS_NONE
				node.mouse_filter = Control.MOUSE_FILTER_STOP if enable else Control.MOUSE_FILTER_IGNORE
				if !enable:
					node.release_focus()
					if last_hovered_node == node:
						last_hovered_node = null
				_enable_disable_menu([node.get_path()], enable)
		

func _process(delta: float) -> void:
	pass
