extends Camera

var mouse = Vector2();
var spawnPos = Vector3();
var spawnNorm: Vector3 = Vector3();
var mirror = false;

var middleButtonDown = false;

var playing = GlobalVar.playing;

onready var roomRoot = get_tree().root.get_node('RoomRoot');

var currentObjSt = 'rocket';

var rocketObj = preload('res://models/3d objects/rocket.tscn');

var wheelObj = preload("res://models/3d objects/wheel.tscn");

var balloonObj = preload("res://models/3d objects/balloon.tscn");



var hingeObj = preload("res://hingeObject.tscn");


var matOk = preload("res://OKpreviewToon.tres");
var matNo = preload("res://previewToon.tres");

var prevWheel = preload("res://models/3d objects/prevWheel.tscn");
var prevRoc = preload("res://models/3d objects/rocketPreview.tscn");
var prevBal = preload("res://models/3d objects/prevBalloon.tscn");

onready var initObj = get_parent().get_parent().get_node("preview");
onready var playerObj =  roomRoot.get_node('Spatial');


onready var curObj = rocketObj;
onready var prevObj = initObj;



onready var cam1 = self;
onready var cam2 = get_parent().get_parent().get_node("int cam 2nd");


export var displ: float = 0.1;



func _input(event):
	playing = GlobalVar.playing;	
	
	if event is  InputEventKey:
		
		if event.physical_scancode == KEY_D:
			get_parent().rotation.y = lerp_angle(get_parent().rotation.y, get_parent().rotation.y+20,0.1);
		if event.physical_scancode == KEY_A:
			get_parent().rotation.y = lerp_angle(get_parent().rotation.y, get_parent().rotation.y-20,0.1);
		if event.physical_scancode == KEY_W:
			get_parent().rotation.x -= 0.1;
		if event.physical_scancode == KEY_S:
			get_parent().rotation.x += 0.1;
		if self.global_translation.y <= 0 && !playing:
			roomRoot.get_node('floor').set('visible', false);
		else:
			roomRoot.get_node('floor').set('visible', true);

			
		if Input.is_action_just_pressed("start"):
			GlobalVar.playing = true;
			playing = true;
			prevObj.set('visible', false);
			cam1.clear_current();
			cam2.make_current();
			roomRoot.get_node('floor').set('visible', true);
			PhysicsServer.set_active(true);
	
		if Input.is_action_just_pressed("wheel") && currentObjSt != 'wheel' && !playing:
			currentObjSt= 'wheel';
			changeObject(prevWheel);
		if Input.is_action_just_pressed("rocket") && currentObjSt != 'rocket' && !playing:
			currentObjSt = 'rocket';
			changeObject(prevRoc);
		if Input.is_action_just_pressed("balloon") && currentObjSt != 'balloon' && !playing:
			currentObjSt = 'balloon';
			changeObject(prevBal);
			
	if event is InputEventMouse and !playing:
		mouse = event.position
		var validClick = getSelection();
		if prevObj.is_inside_tree():
			prevObj.global_translation = spawnPos;
			prevObj.global_transform=  align_with_y(prevObj.global_transform, spawnNorm);
			prevObj.translate_object_local(Vector3(0, displ ,0));
			
		if middleButtonDown:
			print('should orbit');
			

	
		
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == BUTTON_LEFT:
			var validClick = getSelection();
			if validClick:
				createIns(spawnPos,spawnNorm);
		if event.button_index == BUTTON_MIDDLE:
			middleButtonDown = true;
		
	if event is InputEventMouseButton and !event.is_pressed():
		if event.button_index == BUTTON_MIDDLE:
			middleButtonDown = false;
		if event.button_index == BUTTON_WHEEL_UP && self.global_translation.distance_to(get_parent().global_translation) >1.5:
			self.translate_object_local(Vector3(0,0,-0.2));
			
		if event.button_index == BUTTON_WHEEL_DOWN && self.global_translation.distance_to(get_parent().global_translation) < 5:
			self.translate_object_local(Vector3(0,0,0.2));
		
# Called when the node enters the scene tree for the first time.
func _ready():
	self.make_current();
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
		elif currentObjSt == 'balloon':
			curObj = balloonObj;

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
	if !playing:
		var newThing = curObj.instance();
		var newHinge = hingeObj.instance();

		if currentObjSt == 'rocket':
			playerObj.add_child(newThing);
		elif currentObjSt == 'wheel':
			roomRoot.add_child(newThing);
		elif currentObjSt == 'balloon':
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
