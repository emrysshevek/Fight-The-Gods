class_name EnvironmentObject
extends RigidBody2D

@onready var vertex_markers: Array[Node] = $VertexMarkers.get_children()
@onready var platform_shape = $CharacterBody2D/PlatformCollisionShape
@onready var object_shape = $ObjectCollisionShape

func _ready() -> void:
	reset_vertices(object_shape)
	reset_vertices(platform_shape)

func _physics_process(_delta: float) -> void:
	reset_vertices(platform_shape)

func reset_vertices(shape: CollisionPolygon2D) -> void:
	shape.polygon = vertex_markers.map(func(x): return x.position.rotated(rotation))
