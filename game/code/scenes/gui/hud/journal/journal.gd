extends Control

var focused = false;

func editJournal():
	if $Panel/TextEdit.has_focus():
		focused = true;
	if !$Panel/TextEdit.has_focus():
		focused = false;

func saveJournal():
	pass
