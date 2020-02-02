extends Node2D

signal start_work
signal stop_work
signal selected

export (int) var crew_id

var speed = 1
var station = -1
var is_moving = false
var destX
var destY

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _work_station():
	emit_signal("start_work", station)

func _leaving_station():
	emit_signal("stop_work", station)

func _go_to_station(station_position, station_id):
	emit_signal("stop_work", station)
	station = station_id
	destX = station_position[0]
	destY = station_position[1]
	is_moving = true
	#print(station_position)

func _physics_process(_delta):
	if (is_moving):
		if (self.position[1] != destY):
			if self.position[0] != 0:
				_move_toward_ladder()
			else:
				_move_toward_floor()
		elif (self.position[0] != destX):
			_move_toward_dest()
		else:
			is_moving = false
			emit_signal("start_work", station)
			
	pass

func _move_toward_ladder():
	if self.position[0] > speed:
		self.position[0] -= speed
	elif self.position[0] < -speed:
		self.position[0] += speed
	else:
		self.position[0] = 0
	
func _move_toward_floor():
	if self.position[1] > destY + speed:
		self.position[1] -= speed
	elif self.position[1] < destY - speed:
		self.position[1] += speed
	else:
		self.position[1] = destY

func _move_toward_dest():
	if self.position[0] > destX + speed:
		self.position[0] -= speed
	elif self.position[0] < destX - speed:
		self.position[0] += speed
	else:
		self.position[0] = destX

# Check to see if the crew is LEFT CLICKED
func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		emit_signal("selected", self)
		print("Crew Selected")
