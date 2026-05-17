class_name Heap_Array extends Node2D

var nodes: Array[TreeNode] = []
@onready var treeNode = preload("res://treeNode.tscn")

@export var horizontal_gap: float = 250.0 
@export var start_x: float = -1500.0
@export var start_y: float = -350.0
@export var max_items_per_row: int = 20
@export var row_gap: float = 200.0

func rearrange_array() -> void:
	for i in range(nodes.size()):
		var col = i % max_items_per_row
		var row = int(i / max_items_per_row)
		var target_x = start_x + (col * horizontal_gap)
		var target_y = start_y + (row * row_gap) - (int((nodes.size()-1) / max_items_per_row) * row_gap)

		nodes[i].relocate(target_x, target_y)

func _ready() -> void:
	nodes.clear()
	SignalBus.item_inserted.connect(add_node)
	SignalBus.item_removed.connect(remove_node_visual)
	SignalBus.peep_button_pressed.connect(highlight_peek)
	SignalBus.items_swapped.connect(swap)
	SignalBus.node_color_changed.connect(color_node)
	SignalBus.all_nodes_color_reset.connect(reset_all_nodes_color)
	SignalBus.add_halo.connect(add_halo)

func add_node(value: int, index: int) -> void:
	var newNode: TreeNode = treeNode.instantiate()
	newNode.global_position = Vector2(20000, 0)
	add_child(newNode)
	newNode.set_new_node()
	newNode.set_halo(true)
	newNode.set_value(value)
	nodes.append(newNode)
	rearrange_array()

func remove_node_visual(value: int, _index: int) -> void:
	var targetNode = nodes.back()
	targetNode.queue_free()
	nodes.pop_back()
	rearrange_array()
	await get_tree().create_timer(0.001).timeout
	add_halo(_index)
	
func highlight_peek(value: int = 0) -> void:
	if !nodes.is_empty():
		add_halo(0)
		var node = nodes[0]
		node.set_new_node()
		var tween = create_tween()
		tween.tween_property(node, "scale", Vector2(1.4, 1.4), 0.15)
		tween.tween_property(node, "scale", Vector2(1.0, 1.0), 0.15)
		await tween.finished
		node.set_normal()
		
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

func color_node(index: int, color_type: String) -> void:
	if index < 0 or index >= nodes.size():
		return
	nodes[index].set_color_by_type(color_type)

func reset_all_nodes_color() -> void:
	for node in nodes:
		node.set_normal()

func add_halo(index) -> void:
	if index < nodes.size():
		nodes[index].set_halo(true)
