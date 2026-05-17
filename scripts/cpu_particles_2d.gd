extends CPUParticles2D

var number_of_sprays: float = 6
@onready var num: Label = $".."

func _ready():
	var div = 360 / number_of_sprays
	var points = PackedVector2Array()
	var normals = PackedVector2Array()
	points.resize(number_of_sprays)
	normals.resize(number_of_sprays)
	for i in range(number_of_sprays):
		var direction_vector = Vector2.RIGHT.rotated(deg_to_rad(div * i))
		#print(direction_vector)
		points[i] = direction_vector * 20 * sqrt(2)
		normals[i] = direction_vector
	self.emission_points = points
	self.emission_normals = normals

func _process(delta: float) -> void:
	self.rotation = self.rotation + 1 * delta
	if rad_to_deg(self.rotation) > 360:
		self.rotation -= deg_to_rad(360)
	self.emitting = num.text != ""
