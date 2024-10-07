class_name PlayerIdleState
extends PlayerGroundState


func enter(previous_state_path: String, data = {}) -> void:
	player.velocity.x = 0.0
	player.animation_player.play(PlayerAnimationNames.IDLE)


func physics_update(delta: float) -> void:
	super(delta) 
	
	if Input.get_axis("move_left", "move_right"):
		finished.emit(RUN)
