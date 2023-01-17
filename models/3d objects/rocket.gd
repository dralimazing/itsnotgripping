extends RigidBody


# Can probably delete this if we dont need to move the main object directly
export var X_SPEED = 0
export var Z_SPEED = 0
export var Y_SPEED = 0

var velocity = Vector3.ZERO
var player_pos_x = self.translation.x
var player_pos_y = self.translation.y
var player_pos_z = self.translation.z

var mouse = Vector2();
var mouse_sens = 0.3
var camera_anglev=0
var motion;


func update_pos():
	player_pos_x = self.translation.x
	player_pos_y = self.translation.y
	player_pos_z = self.translation.z
	return Vector3(player_pos_x, player_pos_y, player_pos_z)


func _physics_process(delta):

	if Input.is_action_pressed("rocket"):
		print(self.global_transform.basis.y);
		var up = self.global_transform.basis.y
		self.add_force(up * -400,Vector3(0,0,0));
## Called every frame. 'delta' is the elapsed time since the previous frame.

#func _process(delta):
#	pass

