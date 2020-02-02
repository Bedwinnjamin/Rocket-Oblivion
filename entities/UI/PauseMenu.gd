extends Popup

# Called when the node enters the scene tree for the first time.
func _ready():
	var quitButton = $MarginContainer/VBoxContainer/VBoxContainer2/Quit
	quitButton.connect("pressed", self, "_on_Button_pressed", [quitButton.scene_to_load])
	
	var resumeButton = $MarginContainer/VBoxContainer/VBoxContainer2/Resume
	resumeButton.connect("pressed", self, "_on_Resume_pressed")

func _on_Button_pressed(scene_to_load):
	get_tree().paused = false
	get_tree().change_scene(scene_to_load)

func _on_Resume_pressed():
	get_tree().paused = false
	self.hide()
