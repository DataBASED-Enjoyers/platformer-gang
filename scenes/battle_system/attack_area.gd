extends Area2D

signal attack_collide

var collision_shapes := []


func _ready() -> void:
	for child in get_children():
		if child is CollisionShape2D or child is CollisionPolygon2D:
			collision_shapes.append(child)


func _on_body_entered(body: Node2D) -> void:
	for shape in collision_shapes:
		shape.disabled = true
	attack_collide.emit(body)
