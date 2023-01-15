extends RigidBody

onready var cam1 = get_parent().get_node("KinematicBody/InterpolatedCamera");
onready var cam2 = get_parent().get_node("int cam 2nd");

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rocketList: Array = [];

func _input(event):
	if Input.is_action_just_pressed("rocket"):
		cam1.clear_current();
		cam2.make_current();
		PhysicsServer.set_active(true);
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
		if Input.is_action_pressed("rocket"):
			pass
#			for rocket in rocketList:
#				var pos = rocket.global_transform.origin;
#				print(rocket);
#				var up = rocket.global_transform.basis.y*1;
#				self.add_force(-up * 100, pos);
#				print(pos);


func _on_InterpolatedCamera_newRocket(rocket):
	rocketList.append(rocket); # Replace with function body.
