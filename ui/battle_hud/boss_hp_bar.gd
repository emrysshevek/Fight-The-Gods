extends TextureProgressBar

@onready var boss: Boss2 = get_tree().get_first_node_in_group("enemy")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_value = boss.max_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	boss = boss if boss != null else get_tree().get_first_node_in_group("enemy")

	if boss:
		value = boss.health
		#$Label.text = str(boss.health)
