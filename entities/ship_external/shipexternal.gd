extends Sprite

export (int) var float_distance = 20

var originY

# used in sinusoidal up/down func
var degrees = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	# Store original Y value
	originY = self.position[1]

func _physics_process(_delta):
	var sine_factor = sin(degrees/180.0 * PI)
	self.position[1] = originY + (sine_factor * float_distance)
	degrees = (degrees + 1) % 360
