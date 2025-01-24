class_name Hitbox
extends Area2D

signal hit(which_hitbox: Hitbox, which_hurtbox: Hurtbox)

var entity: Entity

func _ready() -> void:
    if not get_parent().is_node_ready():
        await get_parent().ready
	
    entity = get_parent() as Entity

func _on_area_entered(area:Area2D) -> void:
    if area.is_in_group("hurtbox") and area.entity.damageable:
        hit.emit(self, area as Hurtbox)