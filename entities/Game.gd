extends Node

signal resource_update

# Station data, resources and wether being worked or not
# 0 - 6 (Oxygen, Shields, Hull, Fuel, Galaxy, Plants, Radiation)
var working_stations = [false,false,false,false,false,false,false]
var resources = [75.0,100.0,100.0,100.0,0.0,0.0,0.0]
var error

var degrees = 0
var float_distance = 50
var originY

var message

# Used for game time elapsed
var time_start = 0
var time_now = 0
var elapsed = 0
var minutes = 0
var seconds = 0

# Used for missions
var Galaxy = 0
var Plants = 0
var Radiation = 0

# Used for station data retrieval
const Oxygen = 0
const Shields = 1
const Hull = 2
const Fuel = 3

# Used for draining ship values
var fuel_drain = 1.1
var oxygen_drain = .1
var hull_damage = 10

#
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
		
	_tutorial()

# Runs every game frame
func _process(_delta):
	for i in range(0, 3):
		if resources[i] <= 0:
			_lose()
	if(Galaxy!=0):
		if(resources[4]>=Galaxy and resources[5]>=Plants and resources[6]>=Radiation):
			_mission_done()
	$Console._update_clock(str(floor($Mission.time_left)))
	time_now = OS.get_unix_time()
	elapsed = time_now - time_start
	minutes = elapsed / 60
	seconds = elapsed % 60

# Runs at delta time, ignoring FPS
func _physics_process(_delta):
	var sine_factor = sin(degrees/180.0 * PI)
	$Ship.position[1] = originY + (sine_factor * float_distance)+525
	#$Stars.position[1] = (originY + (sine_factor * float_distance))+550
	degrees = (degrees + 1) % 360

# Input handler, listen for ESC to exit app
func _input(event):
	if(event.is_pressed()):
		if(Input.is_key_pressed(KEY_ESCAPE)):
			$PauseMenu.show()
			get_tree().paused = true

# Exits game and loads Lose Scene
func _lose():
	get_tree().change_scene("res://entities/GameOver.tscn")

# Turn music on or off according to station usage
func _station_working(station_id,status,crew):
	working_stations[station_id] = status
	$JukeBox.insert_coin(station_id,status,crew)

# Show basic controls in the console
func _tutorial():
	var t = Timer.new()
	t.set_wait_time(5)
	t.set_one_shot(true)
	self.add_child(t)
	message = "Hello and welcome to Spaceship Simulator. Use your crew of expert astronauts to keep the ship flying with the stations on the left."
	$Console._show_message(message)
	t.start()
	yield(t, "timeout")
	message = "Click on one crew, then click on one of the seven stations to have them work there"
	$Console._clear_message()
	$Console._show_message(message)
	t.start()
	yield(t, "timeout")
	message = "Don't let your ships resources hit 0!"
	$Console._clear_message()
	$Console._show_message(message)
	t.start()
	yield(t, "timeout")
	$Generate.start()
	$Hull_Damage.start()
	$Mission_Alert.start()
	time_start = OS.get_unix_time()
	set_process(true)
	message = "Go!"
	$Console._clear_message()
	$Console._show_message(message)

# Randomly assign values WASA wants, start mission timer
func _generate_mission():
	Galaxy = randi()%21+2
	Plants = randi()%21+2
	Radiation = randi()%21+2
	$Ship/UI/MarginContainer2/Right_Ship/Galaxy.max_value = Galaxy
	$Ship/UI/MarginContainer2/Right_Ship/Plants.max_value = Plants
	$Ship/UI/MarginContainer2/Right_Ship/Radiation.max_value = Radiation
	$Console._clear_message()
	message = "WASA wants:"
	$Console._show_message(message)
	message = (str(Galaxy) + " Galaxy")
	$Console._show_message(message)
	message = (str(Plants) + " Plants")
	$Console._show_message(message)
	message = (str(Radiation) + " Radiation")
	$Console._show_message(message)
	message = ("You have 45 seconds, chop chop!")
	$Console._show_message(message)
	$Mission.start()

# Reset values, countdown to generate new mission
func _mission_done():
	Galaxy = 0
	Plants = 0
	Radiation = 0
	resources[4] = 0
	resources[5] = 0
	resources[6] = 0
	$Ship/UI/MarginContainer2/Right_Ship/Galaxy.max_value = Galaxy
	$Ship/UI/MarginContainer2/Right_Ship/Plants.max_value = Plants
	$Ship/UI/MarginContainer2/Right_Ship/Radiation.max_value = Radiation
	message = ("Well Done, prepare for next mission")
	$Console._show_message(message)
	$Mission_Alert.wait_time = 3
	$Mission_Alert.start()
	$Mission.stop()
	$Mission.start()

# Decrease ship values every second
func _on_Decrease_timeout():
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
	
	# Stations worked by crew increment
	for i in range(0, working_stations.size()):
		if working_stations[i] == true:
			if i < 4:
				if resources[i] <= 99:
					resources[i] +=1
			elif i==4:
				if resources[i] < Galaxy:
					resources[i] +=1
			elif i==5:
				if resources[i] < Plants:
					resources[i] +=1
			elif i==6:
				if resources[i] < Radiation:
					resources[i] +=1
		emit_signal("resource_update", i, resources[i])

# Hull Takes slow damage, damage is worse if shields are low
func _on_Hull_Damage_timeout():
	resources[Hull] -= (hull_damage-(hull_damage*(resources[Shields]/100.0)))
