extends Node2D

signal start_work
signal stop_work

export (int) var crewmember

var is_selected = false
var is_moving = false
var station = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# 
func work_station():
	emit_signal("start_work", station)

func leaving_station():
	emit_signal("stop_work", station)
	# start walking to next station
	#station = next_station

func _input_event(viewport, event, shape_idx):
	if event.type == InputEvent.MOUSE_BUTTON \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		print("Clicked")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
