class_name PlayerWalkState
extends PlayerState


func enter() -> void:
	print("Walk State")
	player.animation_player.play(WALK_ANIM)
