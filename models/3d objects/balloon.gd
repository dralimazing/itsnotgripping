extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if Input.is_action_just_pressed("balloon") && GlobalVar.playing:
		self.mass =0.1;
		gravity_scale = 1
		$CSGMesh.visible = false;
		collision_layer = 3;
		$Timer.start();

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	self.queue_free();
