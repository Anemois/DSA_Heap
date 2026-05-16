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
signal line_color_changed(index: int, color_type: String)
signal all_nodes_color_reset

var stimulation_speed: float = 1
var animation_time: float = 1
