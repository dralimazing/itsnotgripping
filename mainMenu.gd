extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	GlobalVar.currentLevel= 'level1';
	get_tree().change_scene("res://level1.tscn");


func _on_hard_level_pressed():
	GlobalVar.currentLevel= 'level2';
	get_tree().change_scene("res://RoomRoot.tscn");


func _on_level3_pressed():
	GlobalVar.currentLevel= 'level3';
	get_tree().change_scene("res://level3.tscn");


func _on_level4_pressed():
	GlobalVar.currentLevel= 'level4';
	get_tree().change_scene("res://level4.tscn");


func _on_level5_pressed():
	GlobalVar.currentLevel= 'level5';
	get_tree().change_scene("res://level5.tscn");
