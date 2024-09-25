class_name Ball
extends CharacterBody2D

var has_bounced: bool = true
@export var gravity = 980


func get_impulse_from(impulse_source: Vector2, impulse_strength):
	var impulse_direction: Vector2 = (position - impulse_source).normalized()
	has_bounced = false
	velocity = impulse_direction * impulse_strength


func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	move_and_slide()
	apply_bounce()


func apply_bounce():
	if get_slide_collision_count() > 0 and not has_bounced:
		var collider = get_slide_collision(0)
		velocity = velocity.bounce(collider.get_normal())
		has_bounced = true
