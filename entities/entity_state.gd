class_name EntityState
extends State

const DIE := "Die"

func handle_entity_died() -> void:
    finished.emit(DIE)