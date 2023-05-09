extends Spatial

onready var label = $Viewport/Label
onready var audio_player = $AudioPlayer

var fanfare = preload("res://assets/audio/fanfare.mp3")
var cant_pickup = preload("res://assets/audio/VoiceOver/cant_pickup.ogg")
var completed = preload("res://assets/audio/VoiceOver/completed.ogg")
var first_done = preload("res://assets/audio/VoiceOver/first_done.ogg")
var halfway_through = preload("res://assets/audio/VoiceOver/halfway_through.ogg")
var mistake_reaction = preload("res://assets/audio/VoiceOver/mistake_reaction.ogg")
var scanner_pickup = preload("res://assets/audio/VoiceOver/scanner_pickup.ogg")

func _ready():
	Singleton.GUI_panel = self
	
func update_lang():
	if (Singleton.language == "lt"):
		label.text = "Užduotis: Įstatykite kaulus į vietą žmogaus kūne."
	else:
		label.text = "Place the bones on the ground into the human body."
	
	
func update_label():
	if (Singleton.language == "lt"):
		if Singleton.bones_placed >= Singleton.NumberOfBones:
			label.text = "Sveikiname! Viskas pabaigta!"
			play_victory()
		else:
			if (Singleton.bones_placed == 1):
				play_first_done()
			if (Singleton.bones_placed == 15):
				play_halfway()
			label.text = "Sudėta kaulų: " + str(Singleton.bones_placed) + "/" + str(Singleton.NumberOfBones)
	else:
		if Singleton.bones_placed >= Singleton.NumberOfBones:
			label.text = "Congratulations! Everything's finished!"
			play_victory()
		else:
			if (Singleton.bones_placed == 1):
				play_first_done()
			if (Singleton.bones_placed == 15):
				play_halfway()
			label.text = "Bones placed: " + str(Singleton.bones_placed) + "/" + str(Singleton.NumberOfBones)

#TODO: Add english voiceover
#plays info on how to pick up bones and what to do
func play_howto():
	audio_player.stream = cant_pickup
	audio_player.volume_db = Singleton.sound_volume
	audio_player.play()

#plays reminder to turn around
func play_reminder():
	audio_player.stream = mistake_reaction
	audio_player.volume_db = Singleton.sound_volume
	audio_player.play()

#plays congrats after first bone placed
func play_first_done():
	audio_player.stream = first_done
	audio_player.volume_db = Singleton.sound_volume
	audio_player.play()

#plays congrats after over half placed
func play_halfway():
	audio_player.stream = halfway_through
	audio_player.volume_db = Singleton.sound_volume
	audio_player.play()

#plays infor on how to use scanner
func play_scanner_pickup():
	audio_player.stream = scanner_pickup
	audio_player.volume_db = Singleton.sound_volume
	audio_player.play()

#plays fanfare after finishing and then congrats after that
func play_victory():
	audio_player.stream = fanfare
	audio_player.volume_db = Singleton.sound_volume
	audio_player.play()

func _on_AudioPlayer_finished():
	if audio_player.stream == fanfare:
		audio_player.stream = completed
		audio_player.volume_db = Singleton.sound_volume
		audio_player.play()
