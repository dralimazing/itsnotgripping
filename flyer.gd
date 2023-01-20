extends RigidBody

onready var cam1 = get_parent().get_node("cam1 root/InterpolatedCamera");
onready var cam2 = get_parent().get_node("int cam 2nd");

onready var floorNode = get_parent().get_node("floor");

var torq = 5;

var breakForce = 50;

var rocketList: Array = [];



# Called when the node enters the scene tree for the first time.
func _ready():
	$"camera target".set_as_toplevel(true);


func _physics_process(delta):
	$"camera target".global_translation.x = self.global_translation.x;
	$"camera target".global_translation.z = self.global_translation.z +5;
	$"camera target".global_translation.y = self.global_translation.y +2;
	
	if GlobalVar.playing && Input.is_key_pressed(KEY_LEFT):
		add_torque(Vector3(0,torq,0));

	if GlobalVar.playing && Input.is_key_pressed(KEY_RIGHT):
		add_torque(Vector3(0,-torq,0));
	if GlobalVar.playing && Input.is_key_pressed(KEY_DOWN):
		add_torque(Vector3(torq,0,0));
	if GlobalVar.playing && Input.is_key_pressed(KEY_UP):
		add_torque(Vector3(-torq,0,0));

	if Input.is_key_pressed(KEY_SPACE) && GlobalVar.playing && $Area.overlaps_body(floorNode):
		print('breaking');
#		var forward = global_transform.basis.z;
		add_central_force(-linear_velocity*breakForce);
		



func _on_InterpolatedCamera_newRocket(rocket):
	rocketList.append(rocket); # Replace with function body.
