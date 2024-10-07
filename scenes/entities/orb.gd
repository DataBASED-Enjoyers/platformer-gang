extends HurtBox

@export var orb_strength = 600

func hitbox_entered(hit_box: HitBox) -> void:
	if hit_box == null:
		return
	
	if hit_box.owner == owner:
		return
	
	var player = hit_box.owner as Player
	if player:
		var impulse = Vector2(0, -1) * orb_strength
		player.knocks_back(impulse)
