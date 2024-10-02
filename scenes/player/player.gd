class_name Player
extends CharacterBody2D

enum AttackType {
	LOW,
	STRAIGHT,
	HIGH
}

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var speed = 200.0
@export var jump_impulse = 360.0
@export var gravity = 980
@export var falling_gravity = 1200
@export var max_gravity_force = 720
@export var attack_strength = 500
@export var pushback_force: float = 500

var is_knocked_back: bool = false
var knockback_velocity: Vector2 = Vector2.ZERO

var current_attack_type := AttackType.STRAIGHT


# Functions
func _physics_process(_delta: float) -> void:
	if is_knocked_back:
		if sign(velocity.y) != sign(knockback_velocity.y):
			velocity.y = knockback_velocity.y
		else:
			velocity.y += knockback_velocity.y
		
		if sign(velocity.x) != sign(knockback_velocity.x):
			velocity.x = knockback_velocity.x
		else:
			velocity.x += knockback_velocity.x
		
		is_knocked_back = false
		knockback_velocity = Vector2.ZERO
	
	# Key function
	move_and_slide()


func flip_character(direction):
	animated_sprite_2d.scale.x = direction


func _input(event: InputEvent) -> void:
	if event.is_action_released("move_down") or event.is_action_released("move_up"):
		current_attack_type = AttackType.STRAIGHT
	
	if event.is_action_pressed("move_down"):
		current_attack_type = AttackType.LOW
	if event.is_action_pressed("move_up"):
		current_attack_type = AttackType.HIGH
	if event.is_action_pressed("move_down") and event.is_action_pressed("move_up"):
		current_attack_type = AttackType.STRAIGHT
	
	if event.is_action_pressed("punch"):
		match current_attack_type:
			AttackType.LOW:
				animation_player.play(PlayerAnimationNames.J_L_P)
			AttackType.STRAIGHT:
				animation_player.play(PlayerAnimationNames.F_P)
			AttackType.HIGH:
				animation_player.play(PlayerAnimationNames.H_P)
