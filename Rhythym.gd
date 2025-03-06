extends Node2D

@onready var target_scene = preload("Target.tscn")
@export var music_files: Array[String] = ["Devil May Cry 5 - Devil Trigger.mp3", 
"Undertale OST 080 - Finale.mp3", 
"Undertale Ost 087 - Hopes and Dreams.mp3", 
"Undertale Ost 098 - Battle Against a True Hero.mp3", 
"Undertale OST_ 068 - Death by Glamour.mp3"]

@onready var spawn_timer: Timer = $SpawnTimer
@onready var audio_player: AudioStreamPlayer = $Library/AudioStreamPlayer
@onready var game_over_scene = preload("GameOver.tscn")


var current_song_index: int = 0 
var game_over: bool = false

var bpm_data: Dictionary = {
	"Devil May Cry 5 - Devil Trigger.mp3": 80,
	"Undertale OST 080 - Finale.mp3": 95,
	"Undertale Ost 087 - Hopes and Dreams.mp3": 85,
	"Undertale Ost 098 - Battle Against a True Hero.mp3": 75,
	"Undertale OST_ 068 - Death by Glamour.mp3":  74,}
	
var last_song_index: int = -1
var move_chance: float = 0.3

func _ready():
	if has_node("/root/Levels"):
		get_node("/root/Levels/CanvasLayer").visible = false
	if has_node("/root/Sscore"):
		get_node("/root/Sscore/CanvasLayer").visible = false
	if has_node("/root/Rscore"):
		get_node("/root/Rscore/CanvasLayer").visible = true
		game_over = false
	play_random_song()
	
func _on_spawn_timer_timeout():
	if game_over:
		return
	
	
	if target_scene:
		var num_targets = randi() % 100
		if num_targets < 75:
			num_targets = 1
		elif num_targets < 90:
			num_targets = 2
		else:
			num_targets = 3
		
		for i in range(num_targets):
			var target = target_scene.instantiate()
			add_child(target)
			
			var viewport_size = get_viewport_rect().size
			target.global_position = Vector2(randf_range(110, viewport_size.x - 110), randf_range(175, viewport_size.y - 175))
			target.connect("target_expired", Callable(self, "_on_target_expired"))
			
func _on_target_expired():
	if game_over:
		return  # Prevent multiple triggers
	
	game_over = true
	spawn_timer.stop()
	audio_player.stop()

	# Remove all remaining targets
	for child in get_children():
		if child is Area2D:  # Assuming your targets extend Area2D
			child.queue_free()
	
	# Load GameOver scene
	var gameOverInstance = game_over_scene.instantiate()
	get_tree().current_scene.add_child(gameOverInstance)
		


func play_random_song():
	print("🔄 Calling play_random_song()")
	if music_files.is_empty():
		print("⚠ No music files available!")
		return
		
	var available_indexes = Array(range(music_files.size()))  # Convert to Array
	if last_song_index != -1 and last_song_index < available_indexes.size():  
		available_indexes.remove_at(last_song_index)  # Use remove_at() instead of erase_at()
		
	current_song_index = available_indexes.pick_random()  # Pick a random index
	last_song_index = current_song_index  # Update last played song
	
	var song_path = music_files[current_song_index]
	var music_stream = load(song_path)
	
	if music_stream:
		audio_player.stream = music_stream
		audio_player.play()

	if bpm_data.has(song_path):
		var bpm = bpm_data[song_path]
		var beat_interval = 60.0 / bpm  # Convert BPM to seconds per beat
		
		print("🎵 Now playing:", song_path)
		print("🔥 BPM:", bpm, "| ⏳ Spawn Interval:", beat_interval)
		spawn_timer.wait_time = beat_interval
		spawn_timer.start()
	else:
		print("⚠ BPM not found for:", song_path)
		
	if not audio_player.finished.is_connected(Callable(self, "_on_music_finished")):
		audio_player.finished.connect(Callable(self, "_on_music_finished"))
		
func _on_music_finished():
	print("🎶 Song finished, playing next song...")
	play_random_song()
