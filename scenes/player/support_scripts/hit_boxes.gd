extends Node2D

const ATTACK_LAYER = 0b0
const ATTACK_MASK = 0b1100
const ATTACK_BOX_COLOR = 0xff02096b

func _ready() -> void:
	var node_list = get_all_children(self)
	for node in node_list:
		if node is Area2D:
			node.collision_mask = ATTACK_MASK
			node.collision_layer = ATTACK_LAYER
		if node is CollisionShape2D:
			node.disabled = true
			node.debug_color = ATTACK_BOX_COLOR
	visible = true


func get_all_children(node: Node):
	var node_list = [node]
	for child in node.get_children():
		node_list.append_array(get_all_children(child))
	return node_list
	
