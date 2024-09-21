class_name Player
extends CharacterBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var ground_detector: Area2D = $Sprite2D/GroundDetector

@export var speed = 130.0
@export var jump_velocity = -300.0
@export var custom_gravity = 1560
@export var attack_strength = 500

const PUSH_FORCE = 40.0
var is_on_ground: bool = false

# Functions
func _physics_process(delta: float) -> void:
	if not is_on_ground:
		velocity.y += custom_gravity * delta
	
	if Input.is_action_just_pressed("jump") and is_on_ground:
		velocity.y = jump_velocity
		
	var direction = Input.get_axis("move_left", "move_right")
	if direction != 0:
		sprite_2d.scale.x = direction
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	# key function
	move_and_slide()
	
	# Resolve Collisions with RigidBodies
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * PUSH_FORCE)
			if c.get_position().y < (position.y - sprite_2d.get_rect().size.y * scale.y):
				c.get_collider().apply_central_impulse(-c.get_normal() * jump_velocity)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		animation_player.play("attack")


func _on_attack_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("movable_objects"):
		body.get_impluse_from(position, attack_strength)


func _on_ground_detector_body_entered(body: Node2D) -> void:
	is_on_ground = true


func _on_ground_detector_body_exited(body: Node2D) -> void:
	if ground_detector.get_overlapping_bodies().size() == 0:
		is_on_ground = false
