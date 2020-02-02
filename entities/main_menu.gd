extends MarginContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	var button = $MarginContainer/VBoxContainer/MenuOptions/Play
	button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
	
	var exit = $MarginContainer/VBoxContainer/MenuOptions/Exit
	exit.connect("pressed", self, "_on_Exit_pressed")

func _on_Button_pressed(scene_to_load):
	get_tree().change_scene(scene_to_load)
	
func _on_Exit_pressed():
	get_tree().quit()
