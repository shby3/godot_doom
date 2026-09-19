extends AudioStreamPlayer

const MAX_PITCH: float = 3.0
const PITCH_INCREASE: float = 0.75

var cur_pitch: float = 1.0

func _on_finished() -> void:
	if cur_pitch < MAX_PITCH:
		cur_pitch += PITCH_INCREASE
	else:
		cur_pitch = MAX_PITCH
	pitch_scale = cur_pitch
	play()
	
