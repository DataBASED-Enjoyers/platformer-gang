extends PlayerGroundState


func enter(previous_state_path: String, data := {}) -> void:
	player.animation_player.play(PlayerAnimationNames.RUN)


func physics_update(delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
	if not is_equal_approx(direction, 0.0):
		player.flip_character(direction)
	
	player.velocity.x = player.speed * direction
	player.velocity.y += player.gravity * delta
	player.move_and_slide()

	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMPING)
	elif is_equal_approx(direction, 0.0):
		finished.emit(IDLE)
