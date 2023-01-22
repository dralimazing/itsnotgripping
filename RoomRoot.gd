extends Spatial


var itemMap = {'wheel': 2, 'rocket':2, 'balloon': 3, 'piston': 1};
var volume = 0;
onready var audio = $AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	audio.play();
	volume = 0;
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index('Master'), volume);
	if GlobalVar.currentLevel=='level1':
		itemMap = {'wheel': 10, 'rocket':10, 'balloon': 10, 'piston': 10};
	elif GlobalVar.currentLevel == 'level2':
		itemMap = {'wheel': 2, 'rocket':1, 'balloon': 2, 'piston': 1};
	elif GlobalVar.currentLevel == 'level3':
		itemMap = {'wheel': 2, 'rocket':2, 'balloon': 1, 'piston': 1};
	elif GlobalVar.currentLevel == 'level4':
		itemMap = {'wheel': 2, 'rocket':1, 'balloon': 1, 'piston': 1};
	elif GlobalVar.currentLevel == 'level5':
		itemMap = {'wheel': 2, 'rocket':2, 'balloon': 4, 'piston': 1};
	elif GlobalVar.currentLevel == 'level6':
		itemMap = {'wheel': 2, 'rocket':1, 'balloon': 2, 'piston': 2};
func _physics_process(delta):
	if $deathBed.overlaps_body($Spatial) || $Spatial.global_translation.y< -50:
		fadeAudio();
		if volume <= -80:
			reloadScene();
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass





func _on_UI_restart():
	reloadScene()

func reloadScene():
	itemMap = {'wheel': 2, 'rocket':2, 'balloon': 3, 'piston': 1};
	GlobalVar.playing = false;
	get_tree().reload_current_scene();

func fadeAudio():
	volume -=2;
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index('Master'), volume);
