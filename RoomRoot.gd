extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if $deathBed.overlaps_body($Spatial) || $Spatial.global_translation.y< -50:
		GlobalVar.playing = false;
		get_tree().reload_current_scene();
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	GlobalVar.playing = false;
	get_tree().reload_current_scene();
	
	
