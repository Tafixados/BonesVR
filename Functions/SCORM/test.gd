extends Node2D

onready var label = $Label

func _ready():
	updateLabel()

func _on_Button_pressed():
	Singleton.bone_placed(3)
	updateLabel()

func updateLabel():
	var score = str(Singleton.scorm.get_score())
	label.text = "Bones placed: " + str(Singleton.bones_placed) + "\nMode: " + Singleton.mode + "\nStatus: " + Singleton.status + "\nSuccess: " + Singleton.success + "\nScore: " + score
	
