extends RigidBody


var playing = false;

# Can probably delete this if we dont need to move the main object directly
export var X_SPEED = 0
export var Z_SPEED = 0
export var Y_SPEED = 0

var velocity = Vector3.ZERO
var player_pos_x = self.translation.x
var player_pos_y = self.translation.y
var player_pos_z = self.translation.z

var mouse = Vector2();
var mouse_sens = 0.3
var camera_anglev=0
var motion;
onready var audio = $AudioStreamPlayer


func _ready():
	audio.play()

func update_pos():
	player_pos_x = self.translation.x
	player_pos_y = self.translation.y
	player_pos_z = self.translation.z
	return Vector3(player_pos_x, player_pos_y, player_pos_z)


func _physics_process(delta):
	playing = GlobalVar.playing;
	if Input.is_action_pressed("rocket") and playing:
		var up = self.global_transform.basis.y
		self.add_force(up * -200,Vector3(0,0,0));
		if not audio.playing:
			audio.play()
## Called every frame. 'delta' is the elapsed time since the previous frame.

#func _process(delta):
#	pass

