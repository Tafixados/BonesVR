extends Node
var _bone_info: Dictionary
func _ready():
	# open a file
	var file = File.new()
	file.open("res://bone_info.json", file.READ)
	#parse content as json
	var content = file.get_as_text()
	_bone_info = parse_json(content)

func get_value(bone, field):
	if not _bone_info.has(bone):
		return _bone_info["default"][field]
	return _bone_info[bone][field] if _bone_info[bone].has(field) else _bone_info["default"][field]
