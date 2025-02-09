var blockedShader:CustomShader = new CustomShader('blockedShader');
var time:Float = 1;

function postCreate(){
    blockedShader.screenSize = [FlxG.width];
    blockedShader.time = time;
    blockedShader.colorMultiplier = 1;
    blockedShader.hasColorTransform = true;
}

function update(e){
    time += e;
    blockedShader.hset("time", time);
}

function stepHit(){
    switch(curStep){
        case 128:
            defaultCamZoom += 0.1;
            FlxG.camera.flash(FlxColor.WHITE, 0.5);
            black = new FlxSprite().makeSolid(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
            black.screenCenter();
            black.alpha = 0;
            add(black);
            FlxTween.tween(black, {alpha: 0.6}, 1);
            makeInvisibleNotes(true);
        case 165:
            subtitleManager.addSubtitle(getTextString('blocked_sub2'), 0.02, 1);
        case 188:
            subtitleManager.addSubtitle(getTextString('blocked_sub3'), 0.02, 1);
        case 224:
            subtitleManager.addSubtitle(getTextString('blocked_sub4'), 0.02, 1);
        case 248:
            subtitleManager.addSubtitle(getTextString('blocked_sub5'), 0.02, 0.5, 60);
        case 256:
            defaultCamZoom -= 0.1;
            FlxG.camera.flash();
            FlxTween.tween(black, {alpha: 0}, 1);
            makeInvisibleNotes(false);
        case 640:
            FlxG.camera.flash();
            black.alpha = 0.6;
            defaultCamZoom += 0.1;
        case 768:
            FlxG.camera.flash();
            defaultCamZoom -= 0.1;
            black.alpha = 0;
        case 1028:
            makeInvisibleNotes(true);
            subtitleManager.addSubtitle(getTextString('blocked_sub6'), 0.02, 1.5);
        case 1056:
            subtitleManager.addSubtitle(getTextString('blocked_sub7'), 0.02, 1);
        case 1084:
            subtitleManager.addSubtitle(getTextString('blocked_sub8'), 0.02, 1);
        case 1104:
            subtitleManager.addSubtitle(getTextString('blocked_sub9'), 0.02, 1);
        case 1118:
            subtitleManager.addSubtitle(getTextString('blocked_sub10'), 0.02, 1);
        case 1143:
            subtitleManager.addSubtitle(getTextString('blocked_sub11'), 0.02, 1, 45);
            makeInvisibleNotes(false);
        case 1152:
            FlxTween.tween(black, {alpha: 0.4}, 1);
            defaultCamZoom += 0.3;
        case 1200:
            camHUD.addShader(blockedShader);
            fuckCam.addShader(blockedShader);
            FlxTween.tween(black, {alpha: 0.7}, (Conductor.stepCrochet / 1000) * 8);
        case 1216:
            FlxG.camera.flash(FlxColor.WHITE, 0.5);
            camHUD.setFilters([]);
            fuckCam.setFilters([]);
            remove(black);
            defaultCamZoom -= 0.3;
    }
}