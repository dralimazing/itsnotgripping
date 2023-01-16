extends InterpolatedCamera

var mouse = Vector2();
var spawnPos = Vector3();
var spawnNorm: Vector3 = Vector3();


onready var roomRoot = get_tree().root.get_node('RoomRoot');
var currentObj = 'rocket';
var object = preload('res://models/3d objects/rocket.tscn');
var hingeObj = preload("res://hingeObject.tscn");
var matOk = preload("res://OKpreviewToon.tres");
var matNo = preload("res://previewToon.tres");
var prevWheel = preload("res://models/3d objects/prevWheel.tscn");
onready var prevRoc = get_parent().get_parent().get_node("preview");
onready var playerObj =  roomRoot.get_node('Spatial');

signal newRocket(rocket);


export var displ: float = 0.1;



func _input(event):
	
	if event is  InputEventKey:
		if Input.is_action_just_pressed("wheel"):
			object = load('res://models/3d objects/wheel.tscn');
			roomRoot.remove_child(prevRoc);
			var wheelIns = prevWheel.instance();
			wheelIns.scale = Vector3(0.1,0.1,0.1);
			roomRoot.add_child(wheelIns);
			currentObj= 'wheel';
			prevRoc = wheelIns;
			
			
	if event is InputEventMouse:
		mouse = event.position
		var validClick = getSelection();
		prevRoc.global_translation = spawnPos;
		prevRoc.global_transform=  align_with_y(prevRoc.global_transform, spawnNorm);
		prevRoc.translate_object_local(Vector3(0, displ ,0));
	
		
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == BUTTON_LEFT:
			var validClick = getSelection();
			if validClick:
				createIns(spawnPos,spawnNorm);
			
			
# Called when the node enters the scene tree for the first time.
func _ready():
	PhysicsServer.set_active(false);
	
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func getSelection():
	var worldSpace = get_world().direct_space_state;
	var start = project_ray_origin(mouse);
	var end = project_position(mouse, 1000);
	var result = worldSpace.intersect_ray(start, end);

	if !result.empty() :
		spawnPos = result.position;
		spawnNorm = result.normal;
		if playerObj.get_instance_id() == result.collider_id:
			prevRoc.get_node('mesh').set('material/0', matOk);
		else :
			prevRoc.get_node('mesh').set('material/0', matNo);
			return false;
		return true;
	else:
		return false;
	
func createIns(pos, rot):
	var newThing = object.instance();
	var newHinge = hingeObj.instance();
#	get_tree().root.add_child(newHinge);
	roomRoot.add_child(newThing);
	newThing.global_translation = pos;

	newThing.global_transform=  align_with_y(newThing.global_transform, rot);
	
	newThing.scale= Vector3(0.1,0.1,0.1);
	newThing.translate_object_local(Vector3(0,0.1,0));
	if currentObj == 'wheel':
			newThing.get_node('PinJoint').set('nodes/node_a', playerObj.get_path());
	emit_signal("newRocket", newThing);
	
#	newHinge.global_translation = pos;
#	newHinge.set('nodes/node_a', playerObj.get_path());
#	newHinge.set("nodes/node_b", newThing.get_path());
	
func align_with_y(xform, new_y):
	xform.basis.y = new_y
	xform.basis.x = -xform.basis.z.cross(new_y)
	xform.basis = xform.basis.orthonormalized()
	return xform
