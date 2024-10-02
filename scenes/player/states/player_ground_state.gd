class_name PlayerGroundState
extends PlayerState

func physics_update(delta: float) -> void:
	super(delta)
	
	player.velocity.y += player.gravity * delta
	player.move_and_slide()
	
	if not player.is_on_floor():
		finished.emit(FALL)
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMP)
