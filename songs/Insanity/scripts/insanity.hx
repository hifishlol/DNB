var daveMirror:Character = strumLines.members[0].characters[1];
var glitchShader:CustomShader;
var redsky:FunkinSprite;

function postCreate(){
    glitchShader = new CustomShader('glitchShader');
    glitchShader.uWaveAmplitude = 0.1;
    glitchShader.uFrequency = 5;
    glitchShader.uSpeed = 2;

    daveMirror.visible = false;

    add(new FlxSprite(50000).loadGraphic(Paths.image('backgrounds/void/redsky'))); //preloaaaad

    redsky = new FunkinSprite(-600, -200, Paths.image('backgrounds/void/redsky_insanity'));
    redsky.scrollFactor.set(1,1);
    redsky.alpha = 0.75;
    redsky.visible = false;
    insert(members.indexOf(gf)-1, redsky);
    redsky.shader = glitchShader;
}

var time:Float = 0;

function update(e){
    time += e;
    glitchShader.hset("uTime", time);
}

function stepHit(){
    switch (curStep)
    {
        case 384 | 1040:
            defaultCamZoom = 0.9;
        case 448 | 1056:
            defaultCamZoom = 0.8;
        case 512 | 768:
            defaultCamZoom = 1;
        case 640:
            defaultCamZoom = 1.1;
        case 660 | 680:
            FlxG.sound.play(Paths.sound('static'), 0.1);
            dad.visible = false;
            daveMirror.visible = true;
            redsky.visible = true;
            iconP2.setIcon(daveMirror.curCharacter);
        case 664 | 684:
            dad.visible = true;
            daveMirror.visible = false;
            redsky.visible = false;
            iconP2.setIcon(dad.curCharacter);
        case 708:
            defaultCamZoom = 0.8;
            dad.playAnim('um', true);
        case 1176:
            FlxG.sound.play(Paths.sound('static'), 0.1);
            dad.visible = false;
            daveMirror.visible = true;
            redsky.loadGraphic(Paths.image('backgrounds/void/redsky'));
            redsky.alpha = 1;
            redsky.visible = true;
            iconP2.setIcon(daveMirror.curCharacter);
        case 1180:
            dad.visible = true;
            daveMirror.visible = false;
            iconP2.setIcon(dad.curCharacter);
            dad.playAnim('scared', true, 'LOCK');
    }
}