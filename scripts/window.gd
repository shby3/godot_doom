extends Node3D

@onready var interactable: Area3D = $Interactable
@onready var screen: Control = $Screen

@onready var color_level: ColorRect = $SubViewport/ColorLevel
@onready var red_slider: HSlider = $Screen/ColorPicker/RedSlider
@onready var green_slider: HSlider = $Screen/ColorPicker/GreenSlider
@onready var blue_slider: HSlider = $Screen/ColorPicker/BlueSlider

var r_value: int = 0
var g_value: int = 0
var b_value: int = 0
const A_VALUE: int = 106

func _ready() -> void:
	interactable.interact = _on_interact
	set_process_input(false)

func _on_interact() -> void:
	if interactable.is_interactable:
		screen.show()
		set_process_input(true)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		interactable.is_interactable = false
		print("use window")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		screen.hide()
		set_process_input(false)
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		await get_tree().create_timer(0.2).timeout
		interactable.is_interactable = true
		print("unuse window")


func _on_red_slider_value_changed(value: int) -> void:
	r_value = value
	color_level.set_color(Color8(r_value, g_value, b_value, A_VALUE))

func _on_green_slider_value_changed(value: int) -> void:
	g_value = value
	color_level.set_color(Color8(r_value, g_value, b_value, A_VALUE))

func _on_blue_slider_value_changed(value: int) -> void:
	b_value = value
	color_level.set_color(Color8(r_value, g_value, b_value, A_VALUE))
