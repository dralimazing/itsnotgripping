extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var active = preload("res://activePanel.tres");

signal restart; 

var playing = GlobalVar.playing;

onready var rocketPanel = $"VBoxContainer/rocket panel";
onready var wheelPanel = $"VBoxContainer/wheel panel";
onready var balloonPanel = $"VBoxContainer/balloon panel";
onready var pistonPanel = $"VBoxContainer/piston panel";

onready var panelArray = [rocketPanel, wheelPanel, balloonPanel];
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
		
func setActive (panel):
	panel.set('custom_styles/panel', active);
		
func setInactive (panel):
	panel.set('custom_styles/panel', null);
	
func deactivateAllExcept(panel):
	for x in panelArray:
		if x != panel:
			setInactive(x);




func _on_restart_pressed():
	emit_signal("restart") ;
