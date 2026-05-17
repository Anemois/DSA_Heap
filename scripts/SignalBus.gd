extends Node

signal insert_button_pressed(value: int)
signal heapify_button_pressed(value: int)
signal peep_button_pressed(value: int)
signal pop_button_pressed(value: int)
signal item_peeped(value: int, index: int)
signal peep_finished
signal item_inserted(value: int, index: int)
signal insert_finished
signal items_swapped(index_a: int, index_b: int)
signal swap_finished
signal item_removed(value: int, index: int)
signal remove_finished
signal processes_all_finished
signal node_color_changed(index: int, color_type: String)
signal line_color_changed(index: int, color_type: String, up: bool)
signal instant_heap_creation(heap: Array[int])
signal heap_finished
signal all_nodes_color_reset
signal add_halo(index: int)

var stimulation_speed: float = 1
var animation_time: float = 1

var preloaded_array: Array[int] = []
var changed_from_menu: bool

func custom_timer(time: float):
	var timer = Timer.new()
	timer.one_shot = true
	add_child(timer)

	timer.wait_time = time
	timer.start()
	await timer.timeout
	timer.queue_free()

func change_timer_ratio(ratio: float):
	for timer in get_children():
		if timer.time_left > 0.2:
			timer.start(timer.time_left * ratio)
