import flixel.tweens.FlxEase;

function onNoteCreation(e){
    if(e.noteType == 'phone') e.noteSprite = 'game/notes/NOTE_phone';
}

function onDadHit(e){
    if(e.noteType == 'phone'){
        e.animCancelled = true;
        dad.playAnim('singSmash', true);
    }
}

function onPlayerHit(e){
    if(e.noteType == 'phone'){
        e.preventAnim();
        var hitAnimation:Bool = boyfriend.animation.getByName("dodge") != null;
        var heyAnimation:Bool = boyfriend.animation.getByName("hey") != null;
        boyfriend.playAnim(hitAnimation ? 'dodge' : (heyAnimation ? 'hey' : 'singUPmiss'), true);
        gf.playAnim('cheer', true);
        dad.playAnim(dad.animation.getByName("singThrow") == null ? 'singSmash' : 'singThrow', true);
    }
}

var noteAlphaThingy:Array<Float> = [1,1,1,1];

function update(e){
    strumLines.members[1].notes.forEach(function(note:Note){
        for(i in 0...4){
            if(note.strumID == i) note.alpha = noteAlphaThingy[i];
        }
    });
}

function onPlayerMiss(e){
    if(e.noteType == 'phone' && !noMiss){
        var hitAnimation:Bool = boyfriend.animation.getByName("hit") != null;
        boyfriend.playAnim(hitAnimation ? 'hit' : 'singRIGHTmiss', true);
        dad.playAnim(dad.animation.getByName("singThrow") == null ? 'singSmash' : 'singThrow', true);

        var dir = e.direction;

        FlxTween.num(0.01, 1, 7, { ease: FlxEase.expoIn }, 
            (val:Float) -> {noteAlphaThingy[dir] = val;});

        FlxTween.cancelTweensOf(strumLines.members[1].members[e.direction]);
        strumLines.members[1].members[e.direction].alpha = 0.01;
        FlxTween.tween(strumLines.members[1].members[e.direction], {alpha: 1}, 7, {ease: FlxEase.expoIn});
        health -= 0.07;
    }
}