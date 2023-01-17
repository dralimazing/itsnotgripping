extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var roomRoot = get_tree().root.get_node('RoomRoot');
onready var flyer = roomRoot.get_node('Spatial');

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _input(event):
	if event.is_action_pressed ("start"):
		PhysicsServer.set_active(true); 

func _physics_process(delta):
	if Input.is_action_pressed("wheel"):
		var forward = $RigidBody.global_transform.basis.z;

		if $RigidBody/Area.overlaps_body(roomRoot.get_node("floor")):
			$RigidBody.apply_central_impulse(forward*100);
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
