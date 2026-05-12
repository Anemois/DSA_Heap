extends Node

signal insert_button_pressed(value: int)
signal heapify_button_pressed(value: int)
signal peep_button_pressed(value: int)
signal pop_button_pressed(value: int)
signal item_inserted(value: int, index: int)
signal items_swapped(index_a: int, index_b: int)
signal item_removed(value: int, index: int)

var move_speed: float = 0.1
