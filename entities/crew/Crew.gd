extends Node2D

signal start_work
signal stop_work

export (int) var crewmember

var is_selected = false
var is_moving = false
var station = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# 
func work_station():
	emit_signal("start_work", station)

func leaving_station():
	emit_signal("stop_work", station)


func _on_Crew3_start_work():
	pass # Replace with function body.


func _on_Area2D_input_event(event): #viewport, shape_idx
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		var is_selected = true
