class_name Hitbox
extends Area2D

signal hit(which_hitbox: Hitbox, which_hurtbox: Hurtbox)
signal target_entered(which_hitbox: Hitbox, which_hurtbox: Hurtbox)
signal target_exited(which_hitbox: Hitbox, which_hurtbox: Hurtbox)

var targets: Array[Hurtbox] = []

func _physics_process(_delta: float) -> void:
    for target in targets:
        if target.entity.damageable:
            hit.emit(self, target)

func _on_area_entered(area:Area2D) -> void:
    print("area entered hurtbox: ", area)
    if area.is_in_group("hurtbox") and area not in targets:
        targets.append(area as Hurtbox)
        target_entered.emit(self, area as Hurtbox)

func _on_area_exited(area:Area2D) -> void:
    if area is Hurtbox and area in targets:
        targets.erase(area as Hurtbox)
        target_exited.emit(self, area as Hurtbox)
