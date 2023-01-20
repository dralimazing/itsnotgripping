extends Spatial


var itemMap = {'wheel': 2, 'rocket':1, 'balloon': 3, 'piston': 1};

onready var audio = $AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	audio.play()
	if GlobalVar.currentLevel=='level1':
		itemMap = {'wheel': 10, 'rocket':10, 'balloon': 10, 'piston': 10};
	elif GlobalVar.currentLevel == 'level2':
		itemMap = {'wheel': 2, 'rocket':1, 'balloon': 3, 'piston': 1};
func _physics_process(delta):
	if $deathBed.overlaps_body($Spatial) || $Spatial.global_translation.y< -50:
		reloadScene()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass





func _on_UI_restart():
	reloadScene()

func reloadScene():
	itemMap = {'wheel': 1, 'rocket':1, 'balloon': 1, 'piston': 1};
	print(itemMap);
	GlobalVar.playing = false;
	get_tree().reload_current_scene();
