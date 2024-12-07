class_name BaseEnemy
extends CharacterBody2D

@export_category("Characteristics")
@export var health: int = 0:
	get:
		return health
	set(value):
		_set_health(value)

func _set_health(value: int):
	if value < 0:
		_die()

func _die():
	queue_free()
