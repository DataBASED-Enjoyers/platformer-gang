class_name HurtBox
extends Area2D

const HITBOX_LAYER = 0b10000

func _ready():
	collision_layer = 0
	collision_mask = HITBOX_LAYER
	area_entered.connect(hitbox_entered)


func hitbox_entered(hit_box: HitBox) -> void:
	if hit_box == null:
		return
	
	# Deal Damage
	print("Damage Dealt")
