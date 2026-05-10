extends Node2D

var nodes: Array[Node2D]
var length: int = 0
@onready var treeNode = preload("res://treeNode.tscn")

func _ready() -> void:
	nodes.clear()

func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("ui_up")):
		add_node(length)

func add_node(v: int):
	var newNode = treeNode.instantiate()
	newNode.set_value(v)
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
