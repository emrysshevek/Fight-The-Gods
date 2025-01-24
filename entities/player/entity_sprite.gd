class_name EntitySprite
extends AnimatedSprite2D

var active := false

@onready var shader_mat: ShaderMaterial = material as ShaderMaterial
@onready var timer: Timer = Timer.new()

func _ready() -> void:
	timer.wait_time = .1
	timer.one_shot = false
	timer.autostart = false
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

func start_flash() -> void:
	active = true
	shader_mat.set_shader_parameter("active", active)
	timer.start()
	
func end_flash() -> void:
	print("ending flash")
	active = false
	shader_mat.set_shader_parameter("active", active)
	timer.stop()

func _on_timer_timeout() -> void:
	active = !active
	shader_mat.set_shader_parameter("active", active)