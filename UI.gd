extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var active = preload("res://activePanel.tres");

signal restart; 

var playing = GlobalVar.playing;

onready var rocketPanel = $"HBoxContainer/icons/rocketIcon";
onready var wheelPanel = $"HBoxContainer/icons/wheelIcon";
onready var balloonPanel = $"HBoxContainer/icons/balloonIcon";
onready var pistonPanel = $"HBoxContainer/icons/pistonIcon";

onready var rocketLab = $"HBoxContainer/labels/rocket panel/rocket";
onready var wheelLab = $"HBoxContainer/labels/wheel panel/wheel";
onready var balloonLab = $"HBoxContainer/labels/balloon panel/balloon";
onready var pistonLab = $"HBoxContainer/labels/piston panel/piston";


onready var panelArray = [rocketPanel, wheelPanel, balloonPanel, pistonPanel];
onready var lableArray = [rocketLab,wheelLab,balloonLab,pistonLab];
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	playing = GlobalVar.playing;	
	if Input.is_action_pressed("rocket") && !playing:
		setActive(rocketPanel);
		deactivateAllExcept(rocketPanel);
	if Input.is_action_pressed("wheel") && !playing:
		setActive(wheelPanel);
		deactivateAllExcept(wheelPanel);
	if Input.is_action_pressed("balloon") && !playing:
		setActive(balloonPanel);
		deactivateAllExcept(balloonPanel);
	if Input.is_action_pressed("piston") && !playing:
		setActive(pistonPanel);
		deactivateAllExcept(pistonPanel);

	if Input.is_action_pressed("rocket") && playing:
		setActive(rocketPanel);
	if Input.is_action_just_released("rocket") && playing:
		setInactive(rocketPanel);
	if Input.is_action_pressed("wheel") && playing:
		setActive(wheelPanel);
	if Input.is_action_just_released("wheel") && playing:
		setInactive(wheelPanel);
	if Input.is_action_pressed("balloon") && playing:
		setActive(balloonPanel)
	if Input.is_action_just_released("balloon") && playing:
		setInactive(balloonPanel);
	if Input.is_action_just_released("piston") && playing:
		setInactive(pistonPanel);
	
	if Input.is_key_pressed(KEY_ESCAPE):
		$helpUI.visible = false;
func setActive (panel):
	panel.set('modulate', 'ffbf00' );
		
func setInactive (panel):
	panel.set('modulate', 'ffffff' );
	
func deactivateAllExcept(panel):
	for x in panelArray:
		if x != panel:
			setInactive(x);

func _physics_process(delta):
	var itemMap = get_parent().itemMap;
	for lable in lableArray:
		var lab: Label = lable;
		lab.text = 'X ' + str(itemMap[lable.get_name()]);
	
	


func _on_restart_pressed():
	emit_signal("restart") ;


func _on_changeLevel_pressed():
	GlobalVar.currentLevel == 'menu';
	get_tree().change_scene("res://menuScene.tscn");


func _on_helpButton_pressed():
	
	$helpUI.visible = true;


func _on_exitHelp_pressed():
	$helpUI.visible = false;
