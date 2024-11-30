import flixel.addons.display.FlxBackdrop;
import flixel.tweens.FlxEase;
import flixel.text.FlxText.FlxTextBorderStyle;

menuItems = ['Resume', 'Restart Song', 'No Miss Mode', 'Exit to menu'];

function postCreate(){
    backDrop = new FlxBackdrop(Paths.image('uiShared/checkeredBG'), FlxAxes.XY, 1, 1);
    backDrop.alpha = 0;
    backDrop.antialiasing = true;
    backDrop.scrollFactor.set();
    insert(2, backDrop);
    FlxTween.tween(backDrop, {alpha: 0.6}, 0.4, {ease: FlxEase.quartInOut});
    
    var levelInfo = members[3];
    levelInfo.setPosition(FlxG.width - (levelInfo.width + 20), 15);
    levelInfo.setFormat(Paths.font("comic.ttf"), 32, FlxColor.WHITE, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    levelInfo.borderStyle = FlxTextBorderStyle.OUTLINE;
    levelInfo.antialiasing = true;
    levelInfo.borderSize = 2.5;
    levelInfo.updateHitbox();
    for (i in 4...7){
        remove(members[i]);
    }
}
function update(elapsed){
    backDrop.x -= 50 * elapsed;
    backDrop.y -= 50 * elapsed;
}

function onSelectOption(e){
    trace(e.name);
    switch(e.name){
        case 'No Miss Mode':
            trace('test');
    }
}