extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var button = $CenterContainer/VBoxContainer/MainMenu
	button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
	$ShipExternal/AnimationPlayer3.play("ShipAnimation")

func _on_Button_pressed(scene_to_load):
	get_tree().change_scene(scene_to_load)
