class_name Heap_Tree extends Node2D

var nodes: Array[TreeNode]
var length: int = 0
var blink: float = 0.001
var height_diff: int = 220
@onready var treeNode = preload("res://treeNode.tscn")
@onready var line_manager = $LineManager

func _ready() -> void:
	nodes.clear()
	SignalBus.item_inserted.connect(add_node)
	SignalBus.items_swapped.connect(swap)
	SignalBus.item_removed.connect(remove_node)
	SignalBus.node_color_changed.connect(color_node)
	SignalBus.all_nodes_color_reset.connect(reset_all_nodes_color)
	SignalBus.item_peeped.connect(peeped)
	SignalBus.add_halo.connect(add_halo)
	
func _process(delta: float) -> void:
	pass

func add_node(value: int, index: int):
	var newNode: TreeNode = treeNode.instantiate()
	newNode.global_position = Vector2(0, 20000)
	add_child(newNode)
	newNode.set_value(value)
	newNode.set_new_node()
	nodes.append(newNode)
	newNode.set_halo(true)
	length += 1
	rearrange_tree()
	await get_tree().create_timer(SignalBus.animation_time / SignalBus.stimulation_speed).timeout
	SignalBus.insert_finished.emit()

func remove_node(value: int, index: int):
	var targetNode = nodes.back()
	targetNode.queue_free()
	nodes.pop_back()
	length -= 1
	rearrange_tree()
	await get_tree().create_timer(blink).timeout
	SignalBus.remove_finished.emit()
	add_halo(index)

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
			y += height_diff + (tree_height-level) * height_diff/2
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
	var halo_a: bool = Node_a.get_halo()
	var halo_b: bool = Node_b.get_halo()
	
	Node_a.relocate(position_b.x, position_b.y)
	Node_b.relocate(position_a.x, position_a.y)
	await get_tree().create_timer(SignalBus.animation_time / SignalBus.stimulation_speed).timeout
	Node_a.teleport(position_a.x, position_a.y)
	Node_b.teleport(position_b.x, position_b.y)
	Node_a.set_value(value_b)
	Node_b.set_value(value_a)
	Node_a.set_halo(halo_b)
	Node_b.set_halo(halo_a)
	
	SignalBus.swap_finished.emit()	

func color_node(index: int, color_type: String) -> void:
	if index < 0 or index >= nodes.size():
		return
	nodes[index].set_color_by_type(color_type)

func reset_all_nodes_color() -> void:
	for node in nodes:
		node.set_normal()
	for line in line_manager.lines:
		if line != null:
			line.reset()
			
func peeped(value, index) -> void:
	if length > 0:
		add_halo(index)
		nodes[0].set_new_node()
		var tween = create_tween()
		tween.tween_property(nodes[0], "scale", Vector2(1.4, 1.4), 0.15)
		tween.tween_property(nodes[0], "scale", Vector2(1.0, 1.0), 0.15)
		await tween.finished
		nodes[0].set_normal()

func add_halo(index) -> void:
	if index < length:
		nodes[index].set_halo(true)
