extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var active = false;
onready var audio = $AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	audio.play()


func _physics_process(delta):
	if Input.is_action_just_pressed('piston') && GlobalVar.playing:
		active = !active;
		if active:
			$piston/AnimationPlayer.play("New Anim")
			audio.play()
		else: 
			$piston/AnimationPlayer.play_backwards("New Anim");
	
