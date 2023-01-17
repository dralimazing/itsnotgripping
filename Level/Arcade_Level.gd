extends Spatial

var mouse = Vector2();
var spawnPos = Vector3();
var spawnNorm: Vector3 = Vector3();
onready var camera = $player/Camera

var object = preload('res://models/3d objects/rocket.tscn');
var hingeObj = preload("res://hingeObject.tscn");
onready var prevRoc = $preview
var playerObj;
signal newRocket(rocket);

export var displ: float = 0.1;
var rocketList: Array = [];


func _input(event):
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
	if Input.is_action_just_pressed("rocket"):
		PhysicsServer.set_active(true);


func _physics_process(delta):
		if Input.is_action_pressed("rocket"):
			for rocket in rocketList:
				var pos = rocket.global_transform.origin;
				var up = rocket.global_transform.basis.y*5;
				playerObj.add_force(-up * 10, pos);
			


			
# Called when the node enters the scene tree for the first time.
func _ready():
	PhysicsServer.set_active(false);
	playerObj = get_tree().root.get_node('Spatial/player');
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func getSelection():
	var worldSpace = get_world().direct_space_state;
	var start = camera.project_ray_origin(mouse);
	var end = camera.project_position(mouse, 1000);
	var result = worldSpace.intersect_ray(start, end);

	if !result.empty() :
		spawnPos = result.position;
		spawnNorm = result.normal;
		
		return true;
	else:
		return false;
	
func createIns(pos, rot):
	var newThing = object.instance();
	var newHinge = hingeObj.instance();
#	get_tree().root.add_child(newHinge);
	get_tree().root.get_node('Spatial/player').add_child(newThing);
	newThing.global_translation = pos;

	newThing.global_transform=  align_with_y(newThing.global_transform, rot);
	
	newThing.scale= Vector3(0.1,0.1,0.1);
	newThing.translate_object_local(Vector3(0,0.1,0));
	emit_signal("newRocket", newThing);
	
#	newHinge.global_translation = pos;
#	newHinge.set('nodes/node_a', playerObj.get_path());
#	newHinge.set("nodes/node_b", newThing.get_path());
	
func align_with_y(xform, new_y):
	xform.basis.y = new_y
	xform.basis.x = -xform.basis.z.cross(new_y)
	xform.basis = xform.basis.orthonormalized()
	return xform
