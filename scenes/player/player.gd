class_name Player
extends CharacterBody2D

enum AttackType {
	LOW,
	STRAIGHT,
	HIGH
}

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var states: Node2D = $States

@export_category("Characteristics")
@export var health = 20
@export var tea_bar = 24

@export_category("Physics")
@export var speed = 300.0
@export var jump_impulse = 500.0
@export var gravity = 980
@export var additional_falling_gravity = 520


var is_knocked_back: bool = false
var knockback_velocity: Vector2 = Vector2.ZERO

var current_attack_type := AttackType.STRAIGHT
var flipped: bool = false


# Functions
func _physics_process(_delta: float) -> void:
	var direction = Input.get_axis("move_left", "move_right")
	if not is_equal_approx(direction, 0.0):
		flip_character(direction)
		
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
		states.scale.x = direction
		animated_sprite_2d.scale.x = direction


#func _input(event: InputEvent) -> void:
	#if event.is_action_released("move_down") or event.is_action_released("move_up"):
		#current_attack_type = AttackType.STRAIGHT
	#
	#if event.is_action_pressed("move_down"):
		#current_attack_type = AttackType.LOW
	#if event.is_action_pressed("move_up"):
		#current_attack_type = AttackType.HIGH
	#if event.is_action_pressed("move_down") and event.is_action_pressed("move_up"):
		#current_attack_type = AttackType.STRAIGHT


func knocks_back(impulse: Vector2) -> void:
	is_knocked_back = true
	knockback_velocity = impulse
