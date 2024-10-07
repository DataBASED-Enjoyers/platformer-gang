class_name PlayerState
extends State

var player: Player

# Base States
const GROUND_STATE = "GroundState"
const AIRBORNE_STATE = "AirborneState"

# Movement
const IDLE = GROUND_STATE + "/" + "Idle"
const RUN = GROUND_STATE + "/" + "Run"
const JUMP = AIRBORNE_STATE + "/" + "Jump"
const FALL = AIRBORNE_STATE + "/" + "Fall"

# Attack
const GROUNDED_ATTACK = GROUND_STATE + "/" + "GroundedAttack"
const AIRBORNE_ATTACK = AIRBORNE_STATE + "/" + "AirborneAttack"


func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")
	player.animation_player.animation_finished.connect(on_animation_finished)


func on_animation_finished(animation_name: String) -> void:
	pass
