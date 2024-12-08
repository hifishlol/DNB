import openfl.display.BlendMode;
import flixel.FlxObject;
import flixel.math.FlxBasePoint;

public var spotLight:FlxSprite;
var spotLightPart:Bool;
var spotLightScaler:Float = 1.3;

function create(){
    preloadLol = new FlxSprite(9000).loadGraphic(Paths.image('spotLight'));
    preloadLol.alpha = 0.0001;
    add(preloadLol);
}

function beatHit(){
    if (spotLightPart && spotLight != null && spotLight.exists && curBeat % 3 == 0)
    {
        FlxTween.cancelTweensOf(spotLight, ['angle']);
        if (spotLight.health != 3)
        {
            FlxTween.tween(spotLight, {angle: 2}, (Conductor.crochet / 1000) * 3, {ease: FlxEase.expoInOut});
            spotLight.health = 3;
        }
        else
        {
            FlxTween.tween(spotLight, {angle: -2}, (Conductor.crochet / 1000) * 3, {ease: FlxEase.expoInOut});
            spotLight.health = 1;
        }
    }
}

var black:FlxSprite;

function stepHit(){
    switch (curStep)
    {
        case 466:
            defaultCamZoom += 0.2;
            FlxG.camera.flash(FlxColor.WHITE, 0.5);
            black = new FlxSprite().makeSolid(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
            black.screenCenter();
            black.alpha = 0;
            add(black);
            FlxTween.tween(black, {alpha: 0.6}, 1);
            makeInvisibleNotes(true);
            subtitleManager.addSubtitle(getTextString('maze_sub1'), 0.02, 1);
        case 476:
            subtitleManager.addSubtitle(getTextString('maze_sub2'), 0.02, 0.7);
        case 484:
            subtitleManager.addSubtitle(getTextString('maze_sub3'), 0.02, 1);
        case 498:
            subtitleManager.addSubtitle(getTextString('maze_sub4'), 0.02, 1);
        case 510:
            subtitleManager.addSubtitle(getTextString('maze_sub5'), 0.02, 1, 60);
            makeInvisibleNotes(false);
        case 528:
            defaultCamZoom = 0.8;
            black.alpha = 0;
            FlxG.camera.flash();
        case 832:
            defaultCamZoom += 0.2;
            FlxTween.tween(black, {alpha: 0.4}, 1);
        case 838:
            makeInvisibleNotes(true);
            subtitleManager.addSubtitle(getTextString('maze_sub6'), 0.02, 1);
        case 847:
            subtitleManager.addSubtitle(getTextString('maze_sub7'), 0.02, 0.5);
        case 856:
            subtitleManager.addSubtitle(getTextString('maze_sub8'), 0.02, 1);
        case 867:
            subtitleManager.addSubtitle(getTextString('maze_sub9'), 0.02, 1, 40);
        case 879:
            subtitleManager.addSubtitle(getTextString('maze_sub10'), 0.02, 1);
        case 890:
            subtitleManager.addSubtitle(getTextString('maze_sub11'), 0.02, 1);
        case 902:
            subtitleManager.addSubtitle(getTextString('maze_sub12'), 0.02, 1, 60);
            makeInvisibleNotes(false);
        case 908:
            FlxTween.tween(black, {alpha: 1}, (Conductor.stepCrochet / 1000) * 4);
        case 912:
            if (!spotLightPart)
            {
                spotLightPart = true;
                defaultCamZoom -= 0.1;
                FlxG.camera.flash(FlxColor.WHITE, 0.5);

                spotLight = new FlxSprite().loadGraphic(Paths.image('spotLight'));
                spotLight.blend = BlendMode.ADD;
                spotLight.setGraphicSize(Std.int(spotLight.width * (dad.frameWidth / spotLight.width) * spotLightScaler));
                spotLight.updateHitbox();
                spotLight.alpha = 0;
                spotLight.origin.set(spotLight.origin.x,spotLight.origin.y - (spotLight.frameHeight / 2));
                add(spotLight);

                FlxTween.tween(spotLight, {alpha: 0.7}, 1);

                spotLight.setPosition((dad.getGraphicMidpoint().x - spotLight.width / 2) - 10, (dad.getGraphicMidpoint().y + dad.frameHeight / 2 - (spotLight.height)) + 400);	

                updateSpotlight(false);
                
                FlxTween.tween(black, {alpha: 0.6}, 1);
            }
        case 1168:
            spotLightPart = false;
            FlxTween.tween(spotLight, {alpha: 0}, 1, {onComplete: function(tween:FlxTween)
            {
                remove(spotLight);
            }});
            FlxTween.tween(black, {alpha: 0}, 1);
        case 1232:
            FlxG.camera.flash();
    }
}

var lastSinger:Character;

function call(call:String) call == 'true' ? updateSpotlight(true) : updateSpotlight(false); 

function updateSpotlight(bfSinging:Bool)
{
    var curSinger = bfSinging ? boyfriend : dad;

    trace(curSinger.curCharacter);

    if (lastSinger != curSinger)
    {
        bfSinging ? gf.playAnim("singRIGHT", true) : gf.playAnim("singLEFT", true);

        var positionOffset:FlxBasePoint = new FlxBasePoint(0,-150);

        switch (curSinger.curCharacter) //i literally hate math shut up
        {
            case 'bambi-new':
                positionOffset.x = -10;
                positionOffset.y += -250;
            case 'bf-pixel':
                positionOffset.y += -225;
            case 'bf':
                positionOffset.y -= boyfriend.height;
        }
        var targetPosition = new FlxBasePoint(curSinger.getGraphicMidpoint().x - spotLight.width / 2 + positionOffset.x, curSinger.getGraphicMidpoint().y + curSinger.frameHeight / 2 - (spotLight.height) - positionOffset.y);
        
        if (SONG.meta.name.toLowerCase() == 'indignancy')
        {
            targetPosition.y += 80;
        }

        FlxTween.tween(spotLight, {x: targetPosition.x, y: targetPosition.y}, 0.66, {ease: FlxEase.circOut});
        lastSinger = curSinger;
    }
}