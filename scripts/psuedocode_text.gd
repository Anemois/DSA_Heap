extends RichTextLabel

var should_visible = false
@onready var main: Node2D = $"../.."

func _ready() -> void:
	self.add_theme_color_override("font_readonly_color", Color(1.0, 1.0, 1.0, 1.0))
	self.visible = false
	self.add_theme_font_size_override("normal_font_size", 40)
	main.heapify_button_pressed.connect(heapify)
	main.insert_button_pressed.connect(insert)
	main.peep_button_pressed.connect(peep)
	main.pop_button_pressed.connect(pops)

func heapify():
	if(self.name == "Heapify"):
		self.visible = true
	else:
		self.visible = false

func insert(value):
	if(self.name == "Insert"):
		self.visible = true
	else:
		self.visible = false
		
func peep():
	if(self.name == "Peep"):
		self.visible = true
	else:
		self.visible = false
	
func pops():
	if(self.name == "Pop"):
		self.visible = true
	else:
		self.visible = false
	
func change_line_color(line: int, color: Color):
	var slice: String = self.text.get_slice("\n", line)
	#print(slice)
	if(slice != ""):
		self.text = self.text.replace(slice, "[color=#%s]%s[/color]" % [color.to_html(), slice])
		#print("after : ","[color=#%s]%s[/color]" % [color.to_html(), slice] )
