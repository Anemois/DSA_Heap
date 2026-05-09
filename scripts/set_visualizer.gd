extends Control

var set_data: Array = []

@onready var input = $InputRow/InputField
@onready var container = $ScrollContainer/SetContainer

func insert_value(v: int):
	if v in set_data:
		return

	set_data.append(v)
	set_data.sort()
	update_visual()

func remove_value(v: int):
	if v in set_data:
		set_data.erase(v)
		update_visual()

func update_visual():
	# clear UI
	for child in container.get_children():
		child.queue_free()

	# rebuild UI
	for v in set_data:
		var label = Label.new()
		label.text = str(v)

		# maybe style it looks like a "node" ??
		label.add_theme_font_size_override("font_size", 32)
		label.add_theme_color_override("font_color", Color.WHITE)
		
		container.add_child(label)

func _on_insert_pressed():
	if input.text.is_valid_int():
		insert_value(int(input.text))
		input.clear()
		
func _on_remove_pressed():
	if input.text.is_valid_int():
		remove_value(int(input.text))
		input.clear()
