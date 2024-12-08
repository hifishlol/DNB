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
        case 256:
            defaultCamZoom -= 0.1;
            FlxG.camera.flash();
            FlxTween.tween(black, {alpha: 0}, 1);
            makeInvisibleNotes(false);
    }
}