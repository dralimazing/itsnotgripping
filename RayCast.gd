extends RayCast


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var normal = get_collision_normal();
var positions = get_collision_point();
var object = preload("res://instanceTest.tscn");

func _input(event):
	if Input.is_action_pressed("ui_accept"):
		createIns(positions, normal);

# Called when the node enters the scene tree for the first time.
func _process(delta):
	print(positions);
	print(normal);
	positions = get_collision_point();
	normal = get_collision_normal();
	get_node("CSGMesh").global_translation = positions;
	get_node("CSGMesh").global_rotation = normal;
	
	
func createIns(pos, rot):
	var newThing = object.instance();
	get_parent().get_node("KinematicBody").add_child(newThing);
	newThing.global_translation = pos;	
	newThing.global_rotation = rot;
	newThing.scale= Vector3(0.1,0.1,0.1);
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
