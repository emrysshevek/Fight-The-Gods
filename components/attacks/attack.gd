class_name Attack
extends Node2D

@export var damage := 1
@export var active := false

var already_hit: Array[Entity]

@onready var entity: Entity = get_parent() as Entity

func _ready() -> void:
	if entity == null:
		await get_parent().ready
	
	entity = get_parent() as Entity
	assert(entity != null)

func start() -> void:
	active = true
	already_hit = [] 

func end() -> void:
	active = false
	already_hit = []

func _on_hit(_which_hitbox: Hitbox, which_hurtbox: Hurtbox) -> void:
	print(which_hurtbox)
	if active == true and which_hurtbox.entity not in already_hit:
		which_hurtbox.entity.take_damage(damage)
		already_hit.append(which_hurtbox.entity)
