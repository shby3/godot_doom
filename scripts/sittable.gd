extends Node3D

@onready var interactable: Area3D = $Interactable

@export var camera: Camera3D
@export var computer: Node3D
@export var interact_name: String
@export var is_interactable: bool

signal interacted(target_cam: Camera3D, computer: Node3D)
signal interaction_ended(computer: Node3D)

func _ready() -> void:
	interactable.interact = _on_interact
	interactable.interact_name = interact_name
	interactable.is_interactable = is_interactable

func _on_interact() -> void:
	if interactable.is_interactable:
		interactable.is_interactable = false
		emit_signal("interacted", camera, computer)
		print("sit down son")
	else:
		interactable.is_interactable = true
		emit_signal("interaction_ended", computer)
		print("sit up son")
