@tool
extends EditorPlugin

var editor_panel


func _enter_tree() -> void:
	var editor_panel = preload("res://addons/attack_params_editor/attack_params_editor.tscn").instantiate()
	add_control_to_dock(DOCK_SLOT_RIGHT_UL, editor_panel)


func _exit_tree() -> void:
	if editor_panel:
		remove_control_from_docks(editor_panel)
		editor_panel = null
