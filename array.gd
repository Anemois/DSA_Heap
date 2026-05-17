class_name Heap_Array extends Node2D

var nodes: Array[TreeNode] = []
@onready var treeNode = preload("res://treeNode.tscn")

@export var horizontal_gap: float = 250.0 
@export var start_x: float = -1000.0
@export var start_y: float = -350.0
@export var max_items_per_row: int = 20
@export var row_gap: float = 100.0

func rearrange_array() -> void:
	for i in range(nodes.size()):
		var col = i % max_items_per_row
		var row = int(i / max_items_per_row)
		var target_x = start_x + (col * horizontal_gap)
		var target_y = start_y + (row * row_gap)
		
		nodes[i].relocate(target_x, target_y)

func _ready() -> void:
	nodes.clear()
	SignalBus.item_inserted.connect(add_node)
	SignalBus.item_removed.connect(remove_node_visual)
	SignalBus.peep_button_pressed.connect(highlight_peek)

func add_node(value: int, index: int) -> void:
	var newNode: TreeNode = treeNode.instantiate()
	newNode.global_position = Vector2(0, -20000)
	add_child(newNode)
	newNode.set_value(value)
	nodes.append(newNode)
	rearrange_array()

func remove_node_visual(value: int, _index: int) -> void:
	for i in range(nodes.size()):
		if nodes[i].get_value() == value:
			var targetNode = nodes[i]
			targetNode.set_swapping() 
			await get_tree().create_timer(0.25).timeout
			nodes.remove_at(i) 
			targetNode.queue_free() 
			break 
			
	rearrange_array()
	
func highlight_peek(value: int = 0) -> void:
	var heap_logic = $"../HeapLogic"
	var current_max_value = heap_logic.heap[0]
	for node in nodes:
		if node.get_value() == current_max_value:
			node.set_new_node()
			var tween = create_tween()
			tween.tween_property(node, "scale", Vector2(1.4, 1.4), 0.15)
			tween.tween_property(node, "scale", Vector2(1.0, 1.0), 0.15)
			await tween.finished
			node.set_normal()
			break
		
