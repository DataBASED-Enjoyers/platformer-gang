class_name PlayerJumpState
extends PlayerAirborneState


func enter(previous_state_path: String, data := {}) -> void:
	player.velocity.y = -player.jump_impulse
	player.animation_player.play(PlayerAnimationNames.JUMP)


func physics_update(delta: float) -> void:
	super(delta)

	if player.velocity.y >= 0:
		finished.emit(FALL)
