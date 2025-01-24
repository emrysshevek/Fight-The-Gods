class_name Enemy
extends Entity


func _on_contact_hitbox_hit(_which_hitbox:Hitbox, which_hurtbox:Hurtbox) -> void:
	which_hurtbox.entity.take_damage(1)
