extends HBoxContainer

@export var post_content: PostContent

@onready var title: Button = $Title
@onready var author: Label = $Title/Author
@onready var thumb: Sprite2D = $Upvote/Thumb

signal post_pressed(post_content: PostContent)
signal upvote_pressed(icon: Sprite2D)

func _ready() -> void:
	post_content.update_json()
	title.text = post_content.title
	author.text = post_content.author

func _on_title_pressed() -> void:
	post_pressed.emit(post_content)

func _on_upvote_pressed() -> void:
	upvote_pressed.emit(thumb)
