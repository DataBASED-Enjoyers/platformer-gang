class_name PlayerAirborneState
extends PlayerState


func enter(previous_state_path: String, data := {}) -> void:
	finished.emit(FALL)


func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("move_left", "move_right")
	player.velocity.x = player.speed * input_direction_x
	player.velocity.y += player.gravity * delta
	
	if Input.is_action_just_pressed("attack"):
		finished.emit(AIRBORNE_ATTACK)
