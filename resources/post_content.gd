extends Resource
class_name PostContent

@export var title: String
@export var author: String
@export var file: String

var json_as_dict: Dictionary

func update_json() -> void:
	var json_as_text = FileAccess.get_file_as_string(file)
	json_as_dict = JSON.parse_string(json_as_text)
	if json_as_dict and "title" in json_as_dict.keys():
		title = json_as_dict["title"]
	if json_as_dict and "author" in json_as_dict.keys():
		author = json_as_dict["author"]

func get_content() -> String:
	if json_as_dict and "post" in json_as_dict.keys():
		return json_as_dict["post"]
	return ""

func get_comments() -> Array:
	if json_as_dict and "comments" in json_as_dict.keys():
		return json_as_dict["comments"]
	return []
