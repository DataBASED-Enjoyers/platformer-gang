class_name PlayerGroundState
extends PlayerState


func enter(previous_state_path: String, data = {}) -> void:
	if Input.get_axis("move_left", "move_right"):
		finished.emit(RUN)
	else:
		finished.emit(IDLE)


func physics_update(delta: float) -> void:
	super(delta)
	
	player.velocity.y += player.gravity * delta
	
	if not player.is_on_floor():
		finished.emit(FALL)
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMP)
	elif Input.is_action_just_pressed("attack"):
		finished.emit(GROUNDED_ATTACK)
