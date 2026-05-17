class_name Explosion extends CPUParticles2D

func boom() -> void:
	self.one_shot = true
	self.emitting = true
	await get_tree().create_timer(self.lifetime+0.1).timeout
	#print("cleanup")
	queue_free()
