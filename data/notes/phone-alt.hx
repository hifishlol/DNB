import flixel.tweens.FlxEase;

function onNoteCreation(e){
    if(e.noteType == 'phone-alt') e.noteSprite = 'game/notes/NOTE_phone';
}

function onNoteHit(e) if (e.noteType == "phone-alt") e.animSuffix = "-alt";