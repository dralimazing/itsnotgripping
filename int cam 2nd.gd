extends Camera


onready var camTarget= get_parent().get_node("Spatial/camera target");
onready var camLookTarg = get_parent().get_node("Spatial/CSGMesh");
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	
	if camTarget.global_translation.y < 2.442:
		camTarget.global_translation.y =2.442 ;
	else:
		self.global_translation = camTarget.global_translation;
		
	self.global_translation = camTarget.global_translation;
	self.look_at(camLookTarg.global_translation, Vector3.UP);
