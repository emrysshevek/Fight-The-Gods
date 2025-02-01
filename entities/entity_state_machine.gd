class_name EntityStateMachine
extends StateMachine

func _ready() -> void:

	for state_node: EntityState in find_children("*", "State"):
		state_node.finished.connect(_transition_to_next_state)

	await owner.ready
	var entity = owner as Entity
	entity.died.connect(_on_entity_died)
	
	state.enter("")

func _on_entity_died(_which_entity: Entity) -> void:
	if state is EntityState:
		state.handle_entity_died()
