class_name PlayerRunState
extends PlayerGroundState


func enter(previous_state_path: String, data := {}) -> void:
	player.animation_player.play(PlayerAnimationNames.RUN)


func physics_update(delta: float) -> void:
	super(delta)
	
	var direction := Input.get_axis("move_left", "move_right")
	player.velocity.x = player.speed * direction

	if is_equal_approx(direction, 0.0):
		finished.emit(IDLE)
