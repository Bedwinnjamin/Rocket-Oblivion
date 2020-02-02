extends Node

signal resource_update

var working_stations = [false,false,false,false,false,false,false]
var resources = [75.0,100.0,100.0,100.0,0.0,0.0,0.0]
var error

var degrees = 0
var float_distance = 50
var originY

var Oxygen = 0
var Shields = 1
var Hull = 2
var Fuel = 3

var fuel_drain = 1.1
var oxygen_drain = .1
var hull_damage = 10


func _ready():
	originY = $Camera2D.position[1]
	
	var stations = get_tree().get_nodes_in_group("station")
	for s in stations:
		s.connect("working_status", self, "_station_working")
	var bars = get_tree().get_nodes_in_group("bar")
	var i = 0
	for b in bars:
		error = self.connect("resource_update", b, "_update_resource")
		b.value = resources[i]
		i+=1
	
	var message = "Hello and welcome to Spaceship Simulator. Use your crew of expert astronauts to keep the ship flying with the stations on the left."
	$Console._show_message(message)

func _process(_delta):
	for i in range(0, 3):
		if resources[i] == 0:
			_lose()

func _physics_process(_delta):
	var sine_factor = sin(degrees/180.0 * PI)
	$Ship.position[1] = originY + (sine_factor * float_distance)+525
	#$Stars.position[1] = (originY + (sine_factor * float_distance))+550
	degrees = (degrees + 1) % 360

#Input handler, listen for ESC to exit app
func _input(event):
	if(event.is_pressed()):
		if(Input.is_key_pressed(KEY_ESCAPE)):
			$PauseMenu.show()
			get_tree().paused = true

func _lose():
	#get_tree().quit()
	pass


func _station_working(station_id,status,crew):
	$Console._show_message("working station " +  String(station_id))
	working_stations[station_id] = status
	$JukeBox.insert_coin(station_id,status,crew)

func _on_Generate_timeout():
	# Fuel Constantly decreases
	if !working_stations[Fuel]:
		resources[Fuel] -= fuel_drain
	# Shields constantly decreases
	if !working_stations[Shields]:
		resources[Shields] -= fuel_drain
	# Oxygen constantly decreases, worse if hull is low
	if !working_stations[Oxygen]:
		var temp = resources[Hull]
		
		resources[Oxygen] -= (oxygen_drain/(temp/200.00))
		
	for i in range(0, working_stations.size()):
		if working_stations[i] == true:
			if resources[i] <= 99:
				resources[i] +=1
#			elif resources[i] < 100:
#				resources[i] += 100-resources[i]
		emit_signal("resource_update", i, resources[i])

func _on_Hull_Damage_timeout():
	resources[Hull] -= (hull_damage-(hull_damage*(resources[Shields]/100.0)))
	if(resources[Hull] <= 0):
		_lose()
