extends Control

onready var label = $UIPanel/MarginContainer/VBoxContainer/HBoxContainer/LoginName
onready var languageButton = $UIPanel/LanguageButton
onready var VRbutton = $UIPanel/MarginContainer/VBoxContainer/HBox1/Container/VBox/ButtonContainer/EnterVR
onready var title = $UIPanel/MarginContainer/VBoxContainer/TitleContainer/TextureRect

onready var LBDlabel = $UIPanel/MarginContainer/VBoxContainer/HBox1/HBox2/VBox/InfoContainer/LBD
onready var CreditsLabel = $UIPanel/MarginContainer/VBoxContainer/HBox1/HBox2/VBox/InfoContainer/Credits
onready var InfoLabel = $UIPanel/MarginContainer/VBoxContainer/HBox1/HBox2/Container2/InfoLabel

var flag_lt = preload("res://assets/UI/LT_flag.png")
var flag_en = preload("res://assets/UI/EN_flag.png")
var VRicon_lt = preload("res://assets/UI/ButtonLogo.png")
var VRicon_en = preload("res://assets/UI/ButtonLogo_en.png")
var title_lt = preload("res://assets/UI/Title.png")
var title_en = preload("res://assets/UI/Title_en.png")

func _ready():
	Singleton.UI_layer = self
	#get_viewport().connect("size_changed", self, "update_scaling")
	set_process(true)  # Enable process callback
	label.text = "Prisijungė: " + Singleton.learner_name 
	update_scaling()

func _process(delta):
	update_scaling()

func update_scaling():
	var screen_size = get_viewport().get_visible_rect().size
	# Scale ColorRect
	$UIPanel/ColorRect.rect_min_size = screen_size
	$UIPanel.rect_min_size = screen_size
	$UIPanel.rect_scale = Vector2(screen_size.x / $UIPanel.rect_size.x, screen_size.y / $UIPanel.rect_size.y)
	# Scale MarginContainer and its children
	$UIPanel/MarginContainer.rect_min_size = screen_size
	$UIPanel/MarginContainer.rect_scale = Vector2(screen_size.x / $UIPanel/MarginContainer.rect_size.x, screen_size.y / $UIPanel/MarginContainer.rect_size.y)

func _on_LanguageButton_pressed():
	switch_languages()
	if (Singleton.language == "lt"):
		languageButton.text = " LT "
		languageButton.icon = flag_lt
		VRbutton.icon = VRicon_lt
		title.texture = title_lt
		LBDlabel.text = "Mokykitės judėdami!"
		CreditsLabel.text = "Žaidimą kūrė:\nPranas Jaruševičius\nYT: @Tafixados"
		InfoLabel.text = "Surinkite ant grindų išsibarsčiusį žmogaus skeletą. Mažiau klaidų - daugiau taškų! Jei kaulo neatpažįstate, įmeskite į aukurą arba pasinaudokite rankiniu skaitytuvu!\n\nŠiam žaidimui reikalinga Virtualiosios Realybės įranga."
		label.text = "Prisijungė: " + Singleton.learner_name 
	else:
		languageButton.text = " EN "
		languageButton.icon = flag_en
		VRbutton.icon = VRicon_en
		title.texture = title_en
		LBDlabel.text = "Learn by doing!"
		CreditsLabel.text = "Game made by:\nPranas Jaruševičius\nYT: @Tafixados"
		InfoLabel.text = "Collect the human skeleton scattered over the floor. Less mistakes - more points! If you don't recognise a bone, toss it into the brazier or use the scanner!\n\nThis game requires Virtual Reality gear."
		label.text = "Logged in as: " + Singleton.learner_name 
		

func switch_languages():
	if (Singleton.language == "lt"):
		Singleton.change_language("en")
	else:
		Singleton.change_language("lt")

#it's bad code, whatever. It works.
func change_bgm_tracks():
	$UIPanel/MarginContainer/VBoxContainer/HBox1/HBox2._on_Next_pressed()
