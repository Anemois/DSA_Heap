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

func add_node(value: int, index: int) -> void:
	var newNode: TreeNode = treeNode.instantiate()
	newNode.set_value(value)
	nodes.append(newNode)
	add_child(newNode)
	rearrange_array()
