class_name PlayerGroundedAttackState
extends PlayerGroundState

const ATTACK_PARAMS_DIR = "res://assets/player/attack_params/"
var attack_params: AttackParams = ResourceLoader.load(ATTACK_PARAMS_DIR + "straight_punch.tres")


func enter(previous_state_path: String, data = {}) -> void:
	player.animation_player.play(attack_params.animation)


func physics_update(delta: float) -> void:
	super(delta)


func on_animation_finished(animation_name: String) -> void:
	if animation_name == attack_params.animation:
		finished.emit(GROUND_STATE)
