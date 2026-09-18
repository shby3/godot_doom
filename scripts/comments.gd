extends ScrollContainer

@export var title: Label
@export var author: Label
@export var post: RichTextLabel
@export var vbox_container: VBoxContainer

var comment_boxes: Array[PanelContainer] = []


func setup_post(post_content: PostContent) -> void:
	title.text = post_content.title
	author.text = post_content.author
	post.text = post_content.get_content()
	
	# Clear comments
	for comment_box in comment_boxes:
		comment_box.queue_free()
	comment_boxes = []
	
	# Add comments for post
	var comments: Array = post_content.get_comments()
	for comment in comments:
		var comment_box = PanelContainer.new()
		var comment_label = RichTextLabel.new()
		comment_boxes.append(comment_box)
		
		comment_box.add_child(comment_label)
		vbox_container.add_child(comment_box)
		
		comment_label.fit_content = true
		comment_label.text = comment
