extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal won;
# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered(body: Node):
	if body.get_name() == 'Spatial':
#		var enterPos =  body.global_transform.;
		$Particles.emitting = true;
		$winScreen.visible = true;
		emit_signal("won");
		PhysicsServer.set_active(false);
		


func _on_gameplayTimer_timerAtEnd(time):
	print(time);
