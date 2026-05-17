extends Node

signal enemy_died(value: int)
const DEBUG = false

@export var heap: Array[int] = [] 

func insert(value: int) -> void:
	SignalBus.all_nodes_color_reset.emit()
	await SignalBus.custom_timer(SignalBus.animation_time / SignalBus.stimulation_speed * 0.1)
	
	heap.append(value)
	var index = heap.size() - 1
	
	# draw the node first
	SignalBus.item_inserted.emit(value, index)
	
	# Then animate the sifting
	await SignalBus.insert_finished
	await _sift_up(index)
	
	SignalBus.processes_all_finished.emit()

func pop_max(useless: int) -> int:
	SignalBus.all_nodes_color_reset.emit()
	await SignalBus.custom_timer(SignalBus.animation_time / SignalBus.stimulation_speed * 0.1)
	if heap.is_empty():
		push_error("Cannot pop from an empty heap!")
		return -1 
		
	var max_val = heap[0]
	
	# Handle heap with only 1 item
	if heap.size() == 1:
		heap.pop_back()
		SignalBus.item_removed.emit(max_val, 0)
		await SignalBus.remove_finished
		SignalBus.processes_all_finished.emit()
		return max_val
		
	# animate the root swapping with the bottom node before deleting it
	var last_index = heap.size() - 1
	SignalBus.add_halo.emit(last_index)
	SignalBus.node_color_changed.emit(last_index, "swap")
	SignalBus.node_color_changed.emit(0, "swap")
	await SignalBus.custom_timer(SignalBus.animation_time / SignalBus.stimulation_speed / 10 * 0.4)
	
	SignalBus.items_swapped.emit(last_index, 0)
	await SignalBus.swap_finished
	
	heap[0] = heap[last_index]
	heap.pop_back()
	SignalBus.item_removed.emit(max_val, last_index)
	await SignalBus.remove_finished
	
	await _sift_down(0)
	
	SignalBus.processes_all_finished.emit()
	return max_val

func peep(useless: int) -> int:
	if heap.is_empty():
		await SignalBus.custom_timer(SignalBus.animation_time / SignalBus.stimulation_speed * 0.1)
		SignalBus.processes_all_finished.emit()
		return -1
	SignalBus.all_nodes_color_reset.emit()
	SignalBus.item_peeped.emit(heap[0], 0)
	await SignalBus.custom_timer(SignalBus.animation_time / SignalBus.stimulation_speed * 0.1)
	SignalBus.processes_all_finished.emit()
	return heap[0]

func heapify(value) -> void:
	heap = SignalBus.preloaded_array
	SignalBus.instant_heap_creation.emit(heap)
	await SignalBus.custom_timer(1)
	var start_index = (heap.size() / 2) - 1
	print("enter")
	for i in range(start_index, -1, -1):
		await _sift_down(i)
		
	SignalBus.processes_all_finished.emit()
	
func _sift_up(index: int) -> void:
	var parent_index = (index - 1) / 2
	
	if index > 0:
		SignalBus.node_color_changed.emit(index, "compare")
		SignalBus.node_color_changed.emit(parent_index, "compare")
		SignalBus.line_color_changed.emit(index, "compare", true)
		await SignalBus.custom_timer(SignalBus.animation_time / SignalBus.stimulation_speed * 0.4)
	
	if index > 0 and heap[index] > heap[parent_index]:
		SignalBus.node_color_changed.emit(index, "swap")
		SignalBus.node_color_changed.emit(parent_index, "swap")
		await SignalBus.custom_timer(SignalBus.animation_time / SignalBus.stimulation_speed * 0.4)
		
		var temp = heap[index]
		heap[index] = heap[parent_index]
		heap[parent_index] = temp	
		SignalBus.line_color_changed.emit(index, "swap", true)
		SignalBus.items_swapped.emit(index, parent_index)
		await SignalBus.swap_finished
		
		SignalBus.node_color_changed.emit(index, "visited")
		if parent_index == 0:
			SignalBus.node_color_changed.emit(parent_index, "visited")
		await SignalBus.custom_timer(SignalBus.animation_time / SignalBus.stimulation_speed * 0.2)
		
		await _sift_up(parent_index)
	else:
		SignalBus.node_color_changed.emit(index, "visited")
		await SignalBus.custom_timer(SignalBus.animation_time / SignalBus.stimulation_speed * 0.2)

func _sift_down(index: int) -> void:
	var larger_index = index
	var left_child = 2 * index + 1
	var right_child = 2 * index + 2
	
	if left_child < heap.size():
		SignalBus.node_color_changed.emit(index, "compare")
		SignalBus.node_color_changed.emit(left_child, "compare")
		SignalBus.line_color_changed.emit(left_child, "compare", false)
		await SignalBus.custom_timer(SignalBus.animation_time / SignalBus.stimulation_speed * 0.4)
		
		if heap[left_child] > heap[larger_index]:
			larger_index = left_child
		
	if right_child < heap.size():
		SignalBus.node_color_changed.emit(index, "compare")
		SignalBus.node_color_changed.emit(right_child, "compare")
		SignalBus.line_color_changed.emit(right_child, "compare", false)
		await SignalBus.custom_timer(SignalBus.animation_time / SignalBus.stimulation_speed * 0.4)
		
		if heap[right_child] > heap[larger_index]:
			larger_index = right_child
		
	if larger_index != index:
		SignalBus.node_color_changed.emit(index, "swap")
		SignalBus.node_color_changed.emit(larger_index, "swap")
		await SignalBus.custom_timer(SignalBus.animation_time / SignalBus.stimulation_speed * 0.4)
		
		var temp = heap[index]
		heap[index] = heap[larger_index]
		heap[larger_index] = temp
		
		SignalBus.line_color_changed.emit(larger_index, "swap", false)
		SignalBus.items_swapped.emit(index, larger_index)
		await SignalBus.swap_finished
		
		SignalBus.node_color_changed.emit(index, "visited")
		SignalBus.node_color_changed.emit(larger_index, "visited")
		await SignalBus.custom_timer(SignalBus.animation_time / SignalBus.stimulation_speed * 0.2)
		
		await _sift_down(larger_index)
	else:
		SignalBus.node_color_changed.emit(index, "visited")
		await SignalBus.custom_timer(SignalBus.animation_time / SignalBus.stimulation_speed * 0.2)

func _ready() -> void:
	SignalBus.insert_button_pressed.connect(insert)
	SignalBus.pop_button_pressed.connect(pop_max)
	SignalBus.peep_button_pressed.connect(peep)
	SignalBus.heapify_button_pressed.connect(heapify)
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
		var top = await peep(0)
		print("Peeked Value -> ", top)
		assert(top == 100, "FATAL: Peek did not return the root.")
		print("-> Peek Test: PASSED")

		# --- TEST 3: Pop Max ---
		print("\n[Test 3] Executing pop_max()...")
		var removed = await pop_max(0)
		print("Popped Value -> ", removed)
		print("Heap State -> ", heap)
		assert(removed == 100, "FATAL: pop_max did not return the largest value.")
		assert(heap[0] == 50, "FATAL: Heap did not sift down correctly. 50 should be the new root.")
		print("-> Pop Max Test: PASSED")

		# --- TEST 4: Floyd's Heapify ---
		print("\n[Test 4] Executing Bulk Heapify...")
		# We simulate the user overriding the heap with a random list
		var array = [3, 99, 12, 8, 45, 105, 1] 
		print("Raw Array -> ", array)

		heapify(heap) # Run your O(n) algorithm
		print("Heapified State -> ", heap)
		assert(heap[0] == 105, "FATAL: Heapify failed. 105 should be the root.")
		print("-> Heapify Test: PASSED")

		print("\n========================================")
		print("✅ ALL BACKEND SYSTEMS GREEN")
		print("========================================")
