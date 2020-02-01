extends ProgressBar

export (int) var bar_id

func _update_resource(id, value):
	if id == bar_id:
		self.value = value
