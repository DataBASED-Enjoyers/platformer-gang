class_name PlayerFallState
extends PlayerAirborneState


func enter(previous_state_path: String, data := {}) -> void:
	player.animation_player.play(PlayerAnimationNames.FALL)


func physics_update(delta: float) -> void:
	super(delta)
	
	player.velocity.y += player.additional_falling_gravity * delta

	if player.is_on_floor():
		if is_equal_approx(Input.get_axis("move_left", "move_right"), 0.0):
			finished.emit(IDLE)
		else:
			finished.emit(RUN)
