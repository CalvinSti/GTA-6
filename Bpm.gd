extends Node

signal music_playing(beat_interval)

@onready var music_player: AudioStreamPlayer = $AudioStreamPlayer

var bpm = 120  # Default BPM
var current_song: String

var music_tracks = [
	"Devil May Cry 5 - Devil Trigger.mp3",
	"Undertale OST 080 - Finale.mp3",
	"Undertale Ost 087 - Hopes and Dreams.mp3",
	"Undertale Ost 098 - Battle Against a True Hero.mp3",
	"Undertale OST_ 068 - Death by Glamour.mp3",
	"Yu-Gi-Oh! Master Duel Climax Theme #11 (Metal Cover).mp3"
]



func play_random_music():
	# ✅ Pick a random song
	current_song = music_tracks[randi() % music_tracks.size()]
	print("Now playing:", current_song)

	# ✅ Set BPM based on song
	match current_song:
		"Devil May Cry 5 - Devil Trigger.mp3": bpm = 80
		"Undertale OST 080 - Finale.mp3": bpm = 95
		"Undertale Ost 087 - Hopes and Dreams.mp3": bpm = 85
		"Undertale Ost 098 - Battle Against a True Hero.mp3": bpm = 75
		"Undertale OST_ 068 - Death by Glamour.mp3": bpm = 74
		"Yu-Gi-Oh! Master Duel Climax Theme #11 (Metal Cover).mp3": bpm = 82
		_ : bpm = 120  # Default BPM

	# ✅ Convert BPM to beat interval in seconds
	var beat_interval = 60.0 / bpm
	emit_signal("music_playing", beat_interval)

	# ✅ Load and play music
	var music_path = "" + current_song
	var audio_stream = load(music_path)
	if audio_stream:
		music_player.stream = audio_stream
		music_player.play()
	else:
		print("Error: Failed to load music:", music_path)

	# ✅ Wait for song to finish, then start a new one
	await music_player.finished
	play_random_music()
