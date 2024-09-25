class_name Player
extends RigidBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var floor_detector: Area2D = $FloorDetector

@export var speed = 200.0
@export var jump_velocity = 1200.0
#@export var custom_gravity = 1560
@export var attack_strength = 500

const PUSH_FORCE = 40.0
var objects_under_feet: int = 0


# Functions
func _physics_process(delta: float) -> void:
	var velocity: Vector2 = Vector2.ZERO
	
	var direction = Input.get_axis("move_left", "move_right")
	if direction != 0:
		sprite_2d.scale.x = direction
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	# Key function
	var colliding_info = move_and_collide(velocity * delta)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		animation_player.play("attack")
	if event.is_action_pressed("jump") and is_on_floor():
		apply_central_impulse(Vector2(0, -jump_velocity * mass))


func _on_attack_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("movable_objects"):
		body.get_impulse_from(position, attack_strength)


func _on_floor_detector_body_entered(body: Node2D) -> void:
	if body is StaticBody2D:
		objects_under_feet += 1


func _on_floor_detector_body_exited(body: Node2D) -> void:
	if body is StaticBody2D:
		objects_under_feet -= 1
	
	if objects_under_feet < 0:
		objects_under_feet = 0


func is_on_floor():
	return objects_under_feet > 0
