class_name Heap_Tree extends Node2D

var nodes: Array[TreeNode]
var length: int = 0
@onready var treeNode = preload("res://treeNode.tscn")

func _ready() -> void:
	nodes.clear()
	SignalBus.item_inserted.connect(add_node)

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

func rearrange_tree():
	var y: int = 0
	var level: int = 1
	var tree_height: int = ceil(log(length+1)/log(2))
	var tree_weight: int = pow(2,tree_height) * 50
	var row_index: int = 1
	var row_count: int = 1
	var sum: int = length
	for node in nodes:
		node.relocate((tree_weight/row_count)*(row_index-(row_count+1)/2.), y)
		if(row_index == row_count):
			y += 60 + (tree_height-level) * 40
			level += 1
			row_index = 1
			sum -= row_count
			row_count *= 2
		else:
			row_index += 1
