extends Node2D

func _process(delta: float) -> void:
	_draw()
	
func _draw():
	draw_line(Vector2(0, 0), get_global_mouse_position(), Color(255, 255, 255), 30)
