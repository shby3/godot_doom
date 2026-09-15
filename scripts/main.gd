extends Node3D

@export var player: CharacterBody3D
@export var computer_cam: Camera3D
@export var player_cam: Camera3D
@export var computer: Node3D

# Use MOUSE_MODE_CAPTURED when true
var cap_mouse: bool = true

func toggle_pause() -> void:
	cap_mouse = not cap_mouse
	if cap_mouse:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		toggle_pause()

func _on_chair_interacted(target_position: Vector3) -> void:
	player.sit_down(target_position)
	computer_cam.make_current()
	computer.turn_on()


func _on_chair_interaction_ended() -> void:
	player.sit_up()
	player_cam.make_current()
	computer.turn_off()


func _on_window_interacted() -> void:
	pass # Replace with function body.
