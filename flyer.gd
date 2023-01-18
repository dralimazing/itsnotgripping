extends RigidBody

onready var cam1 = get_parent().get_node("cam1 root/InterpolatedCamera");
onready var cam2 = get_parent().get_node("int cam 2nd");

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rocketList: Array = [];



# Called when the node enters the scene tree for the first time.
func _ready():
	$"camera target".set_as_toplevel(true);


func _physics_process(delta):
	$"camera target".global_translation.x = self.global_translation.x;
	$"camera target".global_translation.z = self.global_translation.z +5;
	$"camera target".global_translation.y = self.global_translation.y +2;
	
	
			




func _on_InterpolatedCamera_newRocket(rocket):
	rocketList.append(rocket); # Replace with function body.
