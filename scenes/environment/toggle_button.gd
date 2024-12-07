class_name ToggleButton
extends Area2D

@export var toggling_nodes: Array[Door] = []


func _on_area_entered(area: Area2D) -> void:
	for object in toggling_nodes:
		object.toggle_state()
