extends Camera2D

var zoom_value: float = 0.3
var zoom_increment: float = 0.01
var zoom_max: float = 1.0
var zoom_min: float = 0.05

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		# zoom in
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom_in(get_global_mouse_position())
		# zoom out
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom_out(get_global_mouse_position())
	elif event is InputEventMagnifyGesture:
		mac_zoom(get_global_mouse_position(), event.factor)
	elif event is InputEventMouseMotion:
		if event.button_mask == MOUSE_BUTTON_MASK_LEFT:
			position -= event.relative / zoom
			
func _input(event: InputEvent) -> void:
	pass
	

func mac_zoom(zoom_pos: Vector2, event_factor: float):
	zoom = zoom * sqrt(event_factor)
	global_position += (zoom_pos-global_position)/Vector2(576, 324) * (event_factor-1) * 300

func zoom_in(zoom_pos: Vector2):
	if(zoom_value >= zoom_max):
		return
	zoom_value = min(zoom_value + zoom_increment, zoom_max)
	zoom = zoom_value * Vector2.ONE
	global_position += (zoom_pos-global_position)/zoom * zoom_increment

func zoom_out(zoom_pos: Vector2):
	if(zoom_value <= zoom_min):
		return
	zoom_value = max(zoom_value - zoom_increment, zoom_min)
	zoom = zoom_value * Vector2.ONE
	global_position -= (zoom_pos-global_position)/zoom * zoom_increment
