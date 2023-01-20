extends Control


var time_start = 0
var time_now = 0
signal timerAtEnd;
var str_elapsed = ''
func _ready():
	
	set_process(true)

func _process(delta):
	if GlobalVar.playing:
		if time_start == 0:
			time_start = OS.get_unix_time()
		
		time_now = OS.get_unix_time()
		var elapsed = time_now - time_start
		var minutes = elapsed / 60
		var seconds = elapsed % 60
		str_elapsed = "%02d : %02d" % [minutes, seconds]
		$Label.text = str_elapsed;



func _on_end_won():
	emit_signal("timerAtEnd", str_elapsed)
