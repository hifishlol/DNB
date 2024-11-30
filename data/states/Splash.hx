import openfl.Lib;
import flixel.text.FlxText.FlxTextBorderStyle;
import funkin.backend.assets.ModsFolder;

var animatedIntro:FlxSprite;

var _cachedBgColor:FlxColor;
var _cachedTimestep:Bool;
var _cachedAutoPause:Bool;
var skipScreen:FlxText;

function create(){
    _cachedBgColor = FlxG.cameras.bgColor;
    FlxG.cameras.bgColor = FlxColor.BLACK;

    // This is required for sound and animation to synch up properly
    _cachedTimestep = FlxG.fixedTimestep;
    FlxG.fixedTimestep = false;

    _cachedAutoPause = FlxG.autoPause;
    FlxG.autoPause = false;

    new FlxTimer().start(0.05, ()->{ //cuz it takes time to load the anim
        animatedIntro = new FlxSprite(0,0);
        animatedIntro.frames = Paths.getSparrowAtlas('ui/flixel_intro');
        animatedIntro.animation.addByPrefix('intro', 'intro', 24);
        animatedIntro.animation.play('intro');
        animatedIntro.updateHitbox();
        animatedIntro.antialiasing = false;
        animatedIntro.screenCenter();
        add(animatedIntro);

        new FlxTimer().start(0.636, timerCallback);

        FlxG.sound.load(Paths.sound("flixel")).play();

        if (FlxG.save.data.hasSeenSplash)
        {
            skipScreen = new FlxText(0, FlxG.height, 0, 'Press Enter To Skip', 16);
            skipScreen.setFormat(Paths.getFontName(Paths.font('comic.ttf')), 18, FlxColor.WHITE, 'left', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
            skipScreen.borderSize = 1.5;
            skipScreen.antialiasing = true;
            skipScreen.scrollFactor.set();
            skipScreen.alpha = 0;
            skipScreen.y -= skipScreen.textField.textHeight;
            add(skipScreen);

            FlxTween.tween(skipScreen, {alpha: 1}, 1);
        }
    });
}

function update(elapsed:Float)
{
    if (FlxG.save.data.hasSeenSplash && FlxG.keys.justPressed.ENTER)
    {
        onComplete(null);
    }
}

function timerCallback(Timer:FlxTimer):Void
{
    FlxTween.tween(animatedIntro, {alpha: 0}, 3.0, {ease: FlxEase.quadOut, onComplete: onComplete});
}

function onComplete(Tween:FlxTween):Void
{
    FlxG.cameras.bgColor = _cachedBgColor;
    FlxG.fixedTimestep = _cachedTimestep;
    FlxG.autoPause = _cachedAutoPause;
    ModsFolder.reloadMods();
    FlxG.game._gameJustStarted = true;

    if (!FlxG.save.data.hasSeenSplash)
    {
        FlxG.save.data.hasSeenSplash = true;
        FlxG.save.flush();
    }
}