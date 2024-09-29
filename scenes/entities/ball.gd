class_name Ball
extends RigidBody2D


func get_impulse_from(impulse_source: Vector2, impulse_strength):
	var impulse_direction: Vector2 = (position - impulse_source).normalized()
	apply_central_impulse(impulse_direction * impulse_strength)
