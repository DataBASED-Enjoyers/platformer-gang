class_name PlayerAirborneAttackState
extends PlayerAirborneState

const ATTACK_PARAMS_DIR = "res://assets/player/attack_params/"
var attack_params: AttackParams = ResourceLoader.load(ATTACK_PARAMS_DIR + "jumping_punch.tres")
var is_falling: bool = false


func enter(previous_state_path: String, data = {}) -> void:
	is_falling = previous_state_path == FALL
	player.animation_player.play(attack_params.animation)


func physics_update(delta: float) -> void:
	super(delta)
	
	if is_falling:
		player.velocity.y += player.additional_falling_gravity * delta
	
	if Input.is_action_just_pressed("punch"):
		finished.emit(AIRBORNE_ATTACK)


func on_animation_finished(animation_name: String) -> void:
	if animation_name == attack_params.animation:
		finished.emit(AIRBORNE_STATE)
