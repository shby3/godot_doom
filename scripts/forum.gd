extends Control

const UPVOTE_CODE = [
	true, true, true, false, false, true, false
]

@onready var comments = $Comments
@onready var posts: ScrollContainer = $Posts
@onready var post_container: VBoxContainer = $Posts/VBoxContainer

signal cracked_code

func _on_back_pressed() -> void:
	posts.show()
	comments.hide()

func _on_post_post_pressed(post_content: PostContent) -> void:
	comments.setup_post(post_content)
	comments.show()
	posts.hide()

func _on_post_upvote_pressed(thumb_icon: Sprite2D) -> void:
	thumb_icon.flip_v = !thumb_icon.flip_v
	
	if check_code():
		print("code cracked")
		cracked_code.emit()

func check_code() -> bool:
	var i := 0
	for post in post_container.get_children():
		var is_upvoted = not post.thumb.flip_v
		if i >= len(UPVOTE_CODE) or is_upvoted != UPVOTE_CODE[i]:
			return false
		i += 1

	return true
