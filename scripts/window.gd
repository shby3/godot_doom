extends Node3D

@onready var interactable: Area3D = $Interactable
@onready var screen: Control = $Screen

@onready var color_level: ColorRect = $SubViewport/ColorLevel
@onready var red_slider: HSlider = $Screen/ColorPicker/RedSlider
@onready var green_slider: HSlider = $Screen/ColorPicker/GreenSlider
@onready var blue_slider: HSlider = $Screen/ColorPicker/BlueSlider
@onready var bird_animation: AnimatedSprite2D = $SubViewport/AnimatedSprite2D

signal color_code_cracked
signal interacted
signal interaction_ended

var r_value: int = 0
var g_value: int = 0
var b_value: int = 128
const A_VALUE: int = 144

# Color codes for red sky
const BIRDS_R_TARGET: int = 240
const BIRDS_G_TARGET: int = 20
const BIRDS_B_TARGET: int = 20

# Color codes for bright white screen
const WHITE_R_TARGET: int = 240
const WHITE_G_TARGET: int = 240
const WHITE_B_TARGET: int = 240

# Color coes for green sky
const GREEN_R_TARGET: int = 40
const GREEN_G_TARGET: int = 240
const GREEN_B_TARGET: int = 40

var birds_fled: bool = false
var sky_flashed: bool = false
var code_cracked: bool = false

func _ready() -> void:
	interactable.interact = _on_interact
	set_process_input(false)

func _on_interact() -> void:
	if interactable.is_interactable:
		screen.show()
		set_process_input(true)
		interactable.is_interactable = false
		interacted.emit()
		print("use window")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		screen.hide()
		set_process_input(false)
		interaction_ended.emit()
		await get_tree().create_timer(0.2).timeout
		
		if not code_cracked:
			interactable.is_interactable = true
		
		print("unuse window")


func _on_red_slider_value_changed(value: int) -> void:
	r_value = value
	color_level.set_color(Color8(r_value, g_value, b_value, A_VALUE))
	check_color()

func _on_green_slider_value_changed(value: int) -> void:
	g_value = value
	color_level.set_color(Color8(r_value, g_value, b_value, A_VALUE))
	check_color()

func _on_blue_slider_value_changed(value: int) -> void:
	b_value = value
	color_level.set_color(Color8(r_value, g_value, b_value, A_VALUE))
	check_color()

func check_color() -> void:
	if not birds_fled:
		if r_value >= BIRDS_R_TARGET and b_value <= BIRDS_B_TARGET and g_value <= BIRDS_G_TARGET:
			birds_fled = true
			if is_instance_valid(bird_animation):
				bird_animation.queue_free()
			print("birds fled")
	elif not sky_flashed:
		if r_value >= WHITE_R_TARGET and b_value >= WHITE_B_TARGET and g_value >= WHITE_G_TARGET:
			sky_flashed = true
			print("sky flashed")
	else:
		if r_value <= GREEN_R_TARGET and b_value <= GREEN_B_TARGET and g_value >= GREEN_G_TARGET:
			print("sky green")
			if not code_cracked:
				crack_code()

func crack_code() -> void:
	interactable.is_interactable = false
	code_cracked = true
	
	screen.queue_free()
	set_process_input(false)
	
	color_code_cracked.emit()
	
	print("crack_code")
	
