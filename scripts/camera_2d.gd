extends Camera2D

var zoom_pos = Vector2(576, 324)

var max_zoom_movement = Vector2(576, 324)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		# zoom in
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom_pos = get_global_mouse_position()
			self.zoom += Vector2(0.1, 0.1) * self.zoom
			self.position += (zoom_pos - self.global_position)/(max_zoom_movement) * 50
		# zoom out
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom_pos = get_global_mouse_position()
			self.zoom -= Vector2(0.1, 0.1) * self.zoom
			self.position += (self.global_position - zoom_pos)/(max_zoom_movement) * 50
			# call the zoom function
		#print(zoom_pos, " ", self.global_position)


func _on_pop_button_pressed() -> void:
	pass # Replace with function body.
