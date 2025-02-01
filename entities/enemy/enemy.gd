class_name Enemy
extends Entity

func take_damage(damage: float, _type=null) -> float:
	print("here2")
	damage = super.take_damage(damage)
	if damage > 0:
		sprite.flash(.1)
	return damage
