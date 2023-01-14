extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rocketList = [];


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
		if Input.is_action_pressed("rocket"):
			print(self.global_transform.basis.y);
			for rocket in rocketList:
				print(rocket);
				var up = rocket.global_transform.basis.y
				
				self.add_force(up * 100,rocket.global_transform.position);
			


func _on_InterpolatedCamera_newRocket(rocket):
	rocketList.append(rocket); # Replace with function body.
