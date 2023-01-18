extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var active = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if Input.is_action_just_pressed('piston') && GlobalVar.playing:
		active = !active;
		if active:
			$piston/AnimationPlayer.play("New Anim")
		else: 
			$piston/AnimationPlayer.play_backwards("New Anim");
	
