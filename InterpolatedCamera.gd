extends InterpolatedCamera

var mouse = Vector2();
var spawnPos = Vector3();
var spawnNorm = Vector3();

var object = preload("res://instanceTest.tscn");
var hingeObj = preload("res://hingeObject.tscn");
var playerObj;



func _input(event):
	if event is InputEventMouse:
		mouse = event.position
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == BUTTON_LEFT:
			var validClick = getSelection();
			if validClick:
				createIns(spawnPos,spawnNorm);
			
			
# Called when the node enters the scene tree for the first time.
func _ready():
	 playerObj = get_tree().root.get_node('RoomRoot/Spatial');


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func getSelection():
	var worldSpace = get_world().direct_space_state;
	var start = project_ray_origin(mouse);
	var end = project_position(mouse, 1000);
	var result = worldSpace.intersect_ray(start, end);
	print(result);
	if !result.empty() :
		spawnPos = result.position;
		spawnNorm = result.normal;
		return true;
	else:
		return false;
	
func createIns(pos, rot):
	var newThing = object.instance();
	var newHinge = hingeObj.instance();
	get_tree().root.add_child(newHinge);
	get_tree().root.add_child(newThing);
	newThing.global_translation = pos;	
	newThing.global_rotation = rot;
	newThing.scale= Vector3(0.1,0.1,0.1);
	newHinge.global_translation = pos;
	newHinge.set('nodes/node_a', playerObj.get_path());
	newHinge.set("nodes/node_b", newThing.get_path());
	
