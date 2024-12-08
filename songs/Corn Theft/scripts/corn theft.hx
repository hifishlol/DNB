function stepHit(){
    switch (curStep)
    {
        case 668:
            defaultCamZoom += 0.1;
        case 784:
            defaultCamZoom += 0.1;
        case 848:
            defaultCamZoom -= 0.2;
        case 916:
            FlxG.camera.flash();
        case 935:
            defaultCamZoom += 0.2;
            black = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
            black.screenCenter();
            black.alpha = 0;
            add(black);
            FlxTween.tween(black, {alpha: 0.6}, 1);
            makeInvisibleNotes(true);
            subtitleManager.addSubtitle(getTextString('ctheft_sub1'), 0.02, 1);
        case 945:
            subtitleManager.addSubtitle(getTextString('ctheft_sub2'), 0.02, 1);
        case 976:
            subtitleManager.addSubtitle(getTextString('ctheft_sub3'), 0.02, 0.5);
        case 982:
            subtitleManager.addSubtitle(getTextString('ctheft_sub4'), 0.02, 1);
        case 992:
            subtitleManager.addSubtitle(getTextString('ctheft_sub5'), 0.02, 1);
        case 1002:
            subtitleManager.addSubtitle(getTextString('ctheft_sub6'), 0.02, 0.3);
        case 1007:
            subtitleManager.addSubtitle(getTextString('ctheft_sub7'), 0.02, 0.3);
        case 1033:
            subtitleManager.addSubtitle("Bye Baa!", 0.02, 0.3, 45);
            FlxTween.tween(dad, {alpha: 0}, (Conductor.stepCrochet / 1000) * 6);
            FlxTween.tween(black, {alpha: 0}, (Conductor.stepCrochet / 1000) * 6);
            FlxTween.num(defaultCamZoom, defaultCamZoom + 0.2, (Conductor.stepCrochet / 1000) * 6, {}, function(newValue:Float)
            {
                defaultCamZoom = newValue;
            });
            makeInvisibleNotes(false);
        case 1040:
            defaultCamZoom = 0.8; 
            dad.alpha = 1;
            remove(black);
            FlxG.camera.flash();
    }
}