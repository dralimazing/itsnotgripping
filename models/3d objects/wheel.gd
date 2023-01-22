extends RigidBody


# Declare member variables here. Examples:

onready var roomRoot = get_tree().root.get_node('RoomRoot');
onready var flyer = roomRoot.get_node('Spatial');
onready var audio = $AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	audio.play()

func _input(event):
	if event.is_action_pressed ("start"):

		PhysicsServer.set_active(true); 

func _physics_process(delta):
	if Input.is_action_pressed("wheel"):
		if not audio.playing:
			audio.play()
		var forward = -self.global_transform.basis.z;

 
		if $CollisionShape/Area.overlaps_body(roomRoot.get_node("floor")):
			self.apply_central_impulse(forward*1);
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
