class_name PlayerAnimationNames
extends Node

const STRAIGHT_PUNCH = "punch"
const LOW_PUNCH = "low_punch"
const HIGH_PUNCH = "high_punch"
const JUMPING_PUNCH = "jumping_punch"
const JUMPING_LOW_PUNCH = "jumping_low_punch"
const JUMPING_HIGH_PUNCH = "jumping_high_punch"

const RUN = "run"
const FALL = "fall"
const JUMP = "jump"
const IDLE = "idle"


static func get_attack_animation_names():
	return [STRAIGHT_PUNCH, JUMPING_PUNCH]
