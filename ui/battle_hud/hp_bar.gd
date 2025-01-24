class_name HPBar
extends HBoxContainer

var player: Player

func _ready() -> void:
	get_tree().current_scene.ready.connect(_on_scene_ready)

func _on_scene_ready() -> void:
	player = get_tree().get_first_node_in_group("player") as Player
	assert(player != null, "Player should not be null anymore")

	player.damaged.connect(_on_player_damaged)
	_on_player_damaged(player)

func add_health() -> void:
	var t_rect = TextureRect.new()
	t_rect.texture = preload("res://assets/heart.png")
	add_child(t_rect)

func _on_player_damaged(player: Player) -> void:
	var children = get_children()

	var start = 0
	for i in range(player.health):
		if i >= len(children):
			add_health()
		start += 1

	for i in range(start, len(children)):
		children[len(children) - 1].queue_free()
