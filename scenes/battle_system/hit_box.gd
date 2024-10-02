class_name HitBox
extends Area2D

const HITBOX_LAYER = 0b10000

func _ready():
	collision_layer = HITBOX_LAYER
	collision_mask = 0
