extends Node2D

onready var label = $Label
onready var sprite = $Sprite
onready var textbox1 = $BoneID
onready var textbox2 = $Mistakes
onready var textbox3 = $Score

onready var object = [$Collection/Bones/Skull, $Collection/Bones/Mandible, $Collection/Bones/Spine, $Collection/Bones/Pelvis, $Collection/Bones/Sternum]


func _ready():
	label.text = "Prisijungė: " #+ Singleton.learner_name 

func _on_Button_pressed():
	object[int(textbox1.text)].points = int(textbox2.text)
	object[int(textbox1.text)].brazier_uses += 1
	Singleton.bone_placed(object[int(textbox1.text)])
	label.text = Singleton.suspendstring
	Singleton.scorm.set_time(Singleton.time)
	Singleton.scorm.commit()

func updateLabel():
	var score = str(Singleton.scorm.get_score())
	label.text = "Bones placed: " + str(Singleton.bones_placed) + "\nMode: " + Singleton.mode + "\nStatus: " + Singleton.status + "\nSuccess: " + Singleton.success + "\nScore: " + score
	

func _on_Button2_pressed():
	label.text = Singleton.scorm.seconds_to_scorm_time(Singleton.time)
	#updateLabel()


func _on_Button3_pressed():
	#Singleton.scorm.submit_bone(textbox1.text, textbox2.text, Singleton.time)
	#Singleton.scorm.commit()
	label.text = BoneInfo.get_value(textbox1.text, "Name") + ", " + BoneInfo.get_value(textbox1.text, "Title")
	sprite.set_texture(load(BoneInfo.get_value(textbox1.text, "Image")))

