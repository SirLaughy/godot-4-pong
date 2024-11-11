extends GPUParticles2D

func _on_finished():
	self.queue_free()

func _on_child_entered_tree(node):
	self.emitting = true
