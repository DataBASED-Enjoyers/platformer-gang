class_name Door
extends AnimatableBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var is_opened: bool = false


func toggle_state() -> void:
	print(is_opened)
	if is_opened:
		animation_player.play("close")
		is_opened = false
	else:
		animation_player.play("open")
		is_opened = true
