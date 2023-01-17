extends InterpolatedCamera

var mouse = Vector2();
var spawnPos = Vector3();
var spawnNorm: Vector3 = Vector3();
var mirror = false;

onready var roomRoot = get_tree().root.get_node('RoomRoot');

var currentObjSt = 'rocket';

var rocketObj = preload('res://models/3d objects/rocket.tscn');

var wheelObj = preload("res://models/3d objects/wheel.tscn");

var hingeObj = preload("res://hingeObject.tscn");

var matOk = preload("res://OKpreviewToon.tres");
var matNo = preload("res://previewToon.tres");

var prevWheel = preload("res://models/3d objects/prevWheel.tscn");
var prevRoc = preload("res://models/3d objects/rocketPreview.tscn");

onready var initObj = get_parent().get_parent().get_node("preview");
onready var playerObj =  roomRoot.get_node('Spatial');


onready var curObj = rocketObj;
onready var prevObj = initObj;




export var displ: float = 0.1;



func _input(event):
	
	
	if event is  InputEventKey:
		if Input.is_action_just_pressed("start"):
			PhysicsServer.set_active(true);
		if Input.is_action_just_pressed("wheel") && currentObjSt != 'wheel':
			currentObjSt= 'wheel';
			changeObject(prevWheel);
		if Input.is_action_just_pressed("rocket") && currentObjSt != 'rocket':
			currentObjSt = 'rocket';
			changeObject(prevRoc);
			
	if event is InputEventMouse:
		mouse = event.position
		var validClick = getSelection();
		if prevObj.is_inside_tree():
			prevObj.global_translation = spawnPos;
			prevObj.global_transform=  align_with_y(prevObj.global_transform, spawnNorm);
			prevObj.translate_object_local(Vector3(0, displ ,0));
	
		
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
func changeObject (newObject: Resource):
		
		roomRoot.remove_child(prevObj);
		var newObjIns = newObject.instance();

		roomRoot.add_child(newObjIns);
		prevObj = newObjIns;
		
		if currentObjSt == 'rocket':
			curObj = rocketObj;
		elif currentObjSt == 'wheel':
			curObj = wheelObj;

func getSelection():
	var worldSpace = get_world().direct_space_state;
	var start = project_ray_origin(mouse);
	var end = project_position(mouse, 1000);
	var result = worldSpace.intersect_ray(start, end);

	if !result.empty() :
		spawnPos = result.position;
		spawnNorm = result.normal;
		if playerObj.get_instance_id() == result.collider_id:
			prevObj.get_node('mesh').set('material/0', matOk);
		else :
			prevObj.get_node('mesh').set('material/0', matNo);
			return false;
		return true;
	else:
		return false;
	
func createIns(pos, rot):
	var newThing = curObj.instance();
	var newHinge = hingeObj.instance();

	if currentObjSt == 'rocket':
		playerObj.add_child(newThing);
	elif currentObjSt == 'wheel':
		roomRoot.add_child(newThing);
	
	playerObj.add_child(newHinge);
	newThing.global_translation = pos;

	newThing.global_transform=  align_with_y(newThing.global_transform, rot);

	newThing.translate_object_local(Vector3(0,0.1,0));
#	if currentObj == 'wheel':
#			newThing.get_node('HingeJoint').set('nodes/node_a', playerObj.get_path());

	newHinge.global_translation = pos;
	newHinge.get_node("higne").set('nodes/node_a', playerObj.get_path());
	newHinge.get_node("higne").set("nodes/node_b", newThing.get_path());

	
func align_with_y(xform, new_y):
	xform.basis.y = new_y
	xform.basis.x = -xform.basis.z.cross(new_y)
	xform.basis = xform.basis.orthonormalized()
	return xform
