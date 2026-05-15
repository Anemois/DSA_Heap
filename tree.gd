class_name Heap_Tree extends Node2D

var nodes: Array[TreeNode]
var length: int = 0
@onready var treeNode = preload("res://treeNode.tscn")
@onready var line_manager = $LineManager

func _ready() -> void:
	nodes.clear()
	SignalBus.item_inserted.connect(add_node)
	SignalBus.items_swapped.connect(swap)
	SignalBus.item_removed.connect(remove_node)

func _process(delta: float) -> void:
	pass

func add_node(value: int, index: int):
	print("Hi")
	var newNode: TreeNode = treeNode.instantiate()
	newNode.set_value(value)
	nodes.append(newNode)
	length += 1
	add_child(newNode)
	rearrange_tree()
	await get_tree().create_timer(1.0).timeout
	SignalBus.insert_finished.emit()

func remove_node(value: int, index: int):
	var targetNode = nodes.back()
	targetNode.queue_free()
	nodes.pop_back()
	length -= 1
	rearrange_tree()
	await get_tree().create_timer(0.1).timeout
	SignalBus.remove_finished.emit()

func rearrange_tree():
	var y: int = 0
	var level: int = 1
	var tree_height: int = ceil(log(length+1)/log(2))
	var tree_weight: int = pow(2,tree_height) * 160
	var row_index: int = 1
	var row_count: int = 1
	var sum: int = length
	for node in nodes:
		node.relocate((tree_weight/row_count)*(row_index-(row_count+1)/2.), y)
		if(row_index == row_count):
			y += 200 + (tree_height-level) * 100
			level += 1
			row_index = 1
			sum -= row_count
			row_count *= 2
		else:
			row_index += 1
	line_manager.rearrange()

func swap(index_a: int, index_b: int) -> void:
	var Node_a: Node2D = nodes[index_a]
	var Node_b: Node2D = nodes[index_b]
	var position_a: Vector2 = Node_a.get_assigned_position()
	var position_b: Vector2 = Node_b.get_assigned_position()
	var value_a: int = Node_a.get_value()
	var value_b: int = Node_b.get_value()
	
	Node_a.relocate(position_b.x, position_b.y)
	Node_b.relocate(position_a.x, position_a.y)
	await get_tree().create_timer(0.5).timeout
	Node_a.teleport(position_a.x, position_a.y)
	Node_b.teleport(position_b.x, position_b.y)
	Node_a.set_value(value_b)
	Node_b.set_value(value_a)
	SignalBus.swap_finished.emit()	
