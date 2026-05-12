extends Node

signal enemy_died(value: int)
const DEBUG = false

@export var heap: Array[int] = [] 

func insert(value: int) -> void:
	heap.append(value)
	var index = heap.size() - 1
	
	# draw the node first
	SignalBus.item_inserted.emit(value, index)
	
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
		SignalBus.item_removed.emit(max_val, 0)
		return max_val
		
	# animate the root swapping with the bottom node before deleting it
	var last_index = heap.size() - 1
	SignalBus.items_swapped.emit(last_index, 0)
	
	heap[0] = heap[last_index]
	heap.pop_back()
	SignalBus.item_removed.emit(max_val, last_index)
	
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
		
		SignalBus.items_swapped.emit(index, parent_index)
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
		
		SignalBus.items_swapped.emit(index, larger_index)
		_sift_down(larger_index)

func _ready() -> void:
	SignalBus.insert_button_pressed.connect(insert)
	if DEBUG:
		print("========================================")
		print("🚀 BACKEND DIAGNOSTICS ONLINE")
		print("========================================")

		# --- TEST 1: Insertions ---
		print("\n[Test 1] Executing sequential inserts...")
		insert(10)
		insert(50)
		insert(20)
		insert(100)
		insert(5)
		
		# Check your console: 100 should have bubbled up to index 0!
		print("Heap State -> ", heap) 
		assert(heap[0] == 100, "FATAL: Root is not the maximum after inserts.")
		print("-> Insert Test: PASSED")

		# --- TEST 2: Peek ---
		print("\n[Test 2] Testing Peek...")
		var top = peek()
		print("Peeked Value -> ", top)
		assert(top == 100, "FATAL: Peek did not return the root.")
		print("-> Peek Test: PASSED")

		# --- TEST 3: Pop Max ---
		print("\n[Test 3] Executing pop_max()...")
		var removed = pop_max()
		print("Popped Value -> ", removed)
		print("Heap State -> ", heap)
		assert(removed == 100, "FATAL: pop_max did not return the largest value.")
		assert(heap[0] == 50, "FATAL: Heap did not sift down correctly. 50 should be the new root.")
		print("-> Pop Max Test: PASSED")

		# --- TEST 4: Floyd's Heapify ---
		print("\n[Test 4] Executing Bulk Heapify...")
		# We simulate the user overriding the heap with a random list
		heap = [3, 99, 12, 8, 45, 105, 1] 
		print("Raw Array -> ", heap)

		heapify() # Run your O(n) algorithm
		print("Heapified State -> ", heap)
		assert(heap[0] == 105, "FATAL: Heapify failed. 105 should be the root.")
		print("-> Heapify Test: PASSED")

		print("\n========================================")
		print("✅ ALL BACKEND SYSTEMS GREEN")
		print("========================================")
