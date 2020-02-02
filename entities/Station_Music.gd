extends AudioStreamPlayer

onready var tween_out = $Tween

export(String, FILE) var station_song0
export(String, FILE) var station_song1
export(String, FILE) var station_song2

var songs = []
var track_position

export var transition_duration = 1.00
export var transition_type = 1 # TRANS_SINE

func _ready():
	self.volume_db = -80
	songs = [load(station_song0),load(station_song1),load(station_song2)]
	self.set_stream(songs[0])
	self.play()
	
func _switch_music(crew_id):
	track_position = self.get_playback_position()
	self.set_stream(songs[crew_id])
	self.play(track_position)
	tween_out.interpolate_property(self, "volume_db", -80, -5, transition_duration, transition_type, Tween.EASE_IN, 0)
	tween_out.start()

func _turn_off():
	# tween music volume down to 0
	tween_out.interpolate_property(self, "volume_db", self.volume_db, -80, transition_duration, transition_type, Tween.EASE_IN, 0)
	tween_out.start()
