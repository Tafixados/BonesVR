extends Area
var audio_player

func _on_Walls_body_entered(body):
	
	if body.has_method('out_of_bounds'):
		
		body.out_of_bounds()
		body.mistakes += 1
		
		# Create a new AudioStreamPlayer3D node
		audio_player = AudioStreamPlayer.new()
		# Add the new node as a child of the area (or any other node in the scene)
		add_child(audio_player)
		# Load the audio stream to play (e.g. from a preloaded audio file or another source)
		audio_player.stream = preload("res://assets/audio/mistake.mp3")
		# Connect the finished signal of the audio player to a function that deletes the child node
		audio_player.connect("finished", self, "_on_audio_finished", [audio_player])
		# Change the volume
		audio_player.volume_db = Singleton.sound_volume
		# Start playing the audio
		audio_player.play()
		
		#var sendmessage = "setAnswer(" + body.id + ",true,false,false);"
		#JavaScript.eval(sendmessage)

func _on_audio_finished(audio_player):
	# Delete the audio player child node using the queue_free() method
	audio_player.queue_free()
