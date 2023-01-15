extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rocketList: Array = [];

func _input(event):
	if Input.is_action_just_pressed("rocket"):
		PhysicsServer.set_active(true);
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
		if Input.is_action_pressed("rocket"):
			for rocket in rocketList:
				var pos = rocket.global_transform.origin;
				var up = rocket.global_transform.basis.y*5;
				self.add_force(-up * 10, pos);


func _on_InterpolatedCamera_newRocket(rocket):
	rocketList.append(rocket); # Replace with function body.
