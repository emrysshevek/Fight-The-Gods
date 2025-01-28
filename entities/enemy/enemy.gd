class_name Enemy
extends Entity

func take_damage(damage: float, _type=null) -> void:
	if damage > 0:
		sprite.flash(.1)
		super.take_damage(1)