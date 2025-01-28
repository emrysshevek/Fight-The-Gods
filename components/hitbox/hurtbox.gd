class_name Hurtbox
extends Area2D

signal hit(which_hurtbox: Hurtbox, which_hitbox: Hitbox)

var entity: Entity

func _ready() -> void:
	if not get_parent().is_node_ready():
		await get_parent().ready
	
	entity = get_parent() as Entity

func _on_area_entered(area:Area2D) -> void:
	# print("area entered hurtbox: ", area)
	if area.is_in_group("hitbox") and entity.damageable:
		hit.emit(self, area as Hitbox)
