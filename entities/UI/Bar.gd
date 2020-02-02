extends ProgressBar

export (int) var bar_id
export (String) var bar_name

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = bar_name

func _update_resource(id, value):
	if id == bar_id:
		self.value = value
