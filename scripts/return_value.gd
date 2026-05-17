extends Node2D
@onready var num: Label = $Num
@onready var explosion: CPUParticles2D = $Num/Explosion

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
	explosion.emitting = true
