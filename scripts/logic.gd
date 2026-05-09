extends Node

signal item_inserted(value: int, index: int)
signal items_swapped(index_a: int, index_b: int)
signal item_removed(value: int)

@export var heap: Array[int] = [] 

func insert(value: int) -> void:
	heap.append(value)
	var index = heap.size() - 1
	
	# draw the node first
	item_inserted.emit(value, index)
	
	# Then animate the sifting
	_sift_up(index)
	
func pop_max() -> int:
	if heap.is_empty():
		push_error("Cannot pop from an empty heap!")
		return -1 
		
	var max_val = heap[0]
	
	# Handle heap with only 1 item
	if heap.size() == 1:
		heap.pop_back()
		item_removed.emit(max_val)
		return max_val
		
	# animate the root swapping with the bottom node before deleting it
	var last_index = heap.size() - 1
	items_swapped.emit(0, last_index)
	
	heap[0] = heap[last_index]
	heap.pop_back()
	item_removed.emit(max_val)
	
	_sift_down(0)
	
	return max_val

func peek() -> int:
	if heap.is_empty():
		return -1
	return heap[0]
	
func heapify() -> void:
	var start_index = (heap.size() / 2) - 1
	
	for i in range(start_index, -1, -1):
		_sift_down(i)
	
func _sift_up(index: int) -> void:
	# Corrected Math
	var parent_index = (index - 1) / 2
	
	if index > 0 and heap[index] > heap[parent_index]:
		var temp = heap[index]
		heap[index] = heap[parent_index]
		heap[parent_index] = temp	
		
		items_swapped.emit(index, parent_index)
		_sift_up(parent_index)

func _sift_down(index: int) -> void:
	var larger_index = index
	var left_child = 2 * index + 1
	var right_child = 2 * index + 2
	
	# Ensure left child exists AND is larger
	if left_child < heap.size() and heap[left_child] > heap[larger_index]:
		larger_index = left_child
		
	# Ensure right child exists AND is larger
	if right_child < heap.size() and heap[right_child] > heap[larger_index]:
		larger_index = right_child
		
	# Base Case
	if larger_index != index:
		var temp = heap[index]
		heap[index] = heap[larger_index]
		heap[larger_index] = temp
		
		items_swapped.emit(index, larger_index)
		_sift_down(larger_index)
