extends Node3D

@export var player: CharacterBody3D
@export var player_cam: Camera3D

const WORLD_SPEED: float = 0.25

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

func _on_screen_interacted(target_cam: Camera3D, computer: Node3D) -> void:
	target_cam.make_current()
	player.sit_down()
	computer.turn_on()

func _on_screen_interaction_ended(computer: Node3D) -> void:
	player_cam.make_current()
	player.sit_up()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	computer.turn_off()
