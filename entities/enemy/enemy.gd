class_name Enemy
extends Entity

func take_damage(damage: float, _type=null) -> float:
	damage = super.take_damage(damage * (1 + Globals.difficulty_multiplier))
	if damage > 0:
		sprite.flash(.125)
	return damage
