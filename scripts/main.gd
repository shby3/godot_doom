extends Node3D

@export var player: CharacterBody3D
@export var player_cam: Camera3D

const WORLD_SPEED: float = 0.25

# Use MOUSE_MODE_CAPTURED when true
var cap_mouse: bool = true

@onready var animation_player = $AnimationPlayer
@onready var teleport_spawn: Marker3D = $TeleportSpawn

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

func _on_window_color_code_cracked() -> void:
	player.sit_up()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	animation_player.play("window_wall_rotation")

func _on_window_interacted() -> void:
	player.sit_down()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_window_interaction_ended() -> void:
	player.sit_up()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_collectible_collected() -> void:
	pass # Replace with function body.

func _on_teleporter_interacted() -> void:
	player.global_position = teleport_spawn.global_position

func _on_number_screen_fairy_collected() -> void:
	player.sit_up()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	player_cam.make_current()
