class_name ImgButton
extends TextureButton

var elapsed := 0.0
var a := 4
var f := .4
var p := randf_range(0, 2 * PI)

var base_position: Vector2

func _ready() -> void:
    base_position = position

func _process(delta: float) -> void:
    elapsed += delta

    var offset = a * sin(2 * PI * f * elapsed + p)
    position.y = base_position.y + offset

func restart() -> void:
    base_position = position