extends Node
var _bone_info_lt: Dictionary
var _bone_info_en: Dictionary

func _ready():
	# open a file
	var file_lt = File.new()
	file_lt.open("res://bone_info_lt.json", file_lt.READ)
	#parse content as json
	var content_lt = file_lt.get_as_text()
	_bone_info_lt = parse_json(content_lt)
	
	#Do the same for the EN version
	# open a file
	var file_en = File.new()
	file_en.open("res://bone_info_en.json", file_en.READ)
	#parse content as json
	var content_en = file_en.get_as_text()
	_bone_info_en = parse_json(content_en)

#can't be bothered to optimize, 2 languages is enough
func get_value_lt(bone, field):
	if not _bone_info_lt.has(bone):
		return _bone_info_lt["default"][field]
	return _bone_info_lt[bone][field] if _bone_info_lt[bone].has(field) else _bone_info_lt["default"][field]
	
func get_value_en(bone, field):
	if not _bone_info_en.has(bone):
		return _bone_info_en["default"][field]
	return _bone_info_en[bone][field] if _bone_info_en[bone].has(field) else _bone_info_en["default"][field]
