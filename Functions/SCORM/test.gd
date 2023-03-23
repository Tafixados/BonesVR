extends Node2D

onready var label = $Label
onready var sprite = $Sprite
onready var textbox1 = $BoneID
onready var textbox2 = $Mistakes
onready var textbox3 = $Score


func _on_Button_pressed():
	Singleton.bone_placed(3)
	#updateLabel()

func updateLabel():
	var score = str(Singleton.scorm.get_score())
	label.text = "Bones placed: " + str(Singleton.bones_placed) + "\nMode: " + Singleton.mode + "\nStatus: " + Singleton.status + "\nSuccess: " + Singleton.success + "\nScore: " + score
	

func _on_Button2_pressed():
	var score = int(textbox3.text)
	if score > 20:
		score = score - 20
	else:
		score = 0
	textbox3.text = str(score)
	textbox2.text = str(int(textbox2.text) + 1)


func _on_Button3_pressed():
	#Singleton.scorm.submit_bone(textbox1.text, textbox2.text, Singleton.time)
	#Singleton.scorm.commit()
	label.text = BoneInfo.get_value(textbox1.text, "Name") + ", " + BoneInfo.get_value(textbox1.text, "Title")
	sprite.set_texture(load(BoneInfo.get_value(textbox1.text, "Image")))

