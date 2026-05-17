extends Node2D
@onready var num: Label = $Num
const EXPLOSION = preload("uid://bpld6pyh6m8kd")

func _ready() -> void:
	SignalBus.item_peeped.connect(show_me_the_money)
	SignalBus.item_removed.connect(show_me_the_money)
	SignalBus.insert_button_pressed.connect(awww)

func awww(value) -> void:
	num.text = ""

func show_me_the_money(value, index) -> void:
	explode()
	num.text = str(value)

func explode() -> void:
	var new_exp: Explosion = EXPLOSION.instantiate()
	num.add_child(new_exp)
	new_exp.position = Vector2(34, 14)
	new_exp.boom()
