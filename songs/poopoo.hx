import flixel.text.FlxText.FlxTextBorderStyle;
import flixel.ui.FlxBar;
import flixel.ui.FlxBar.FlxBarFillDirection;
import flixel.util.FlxStringUtil;
import SubtitleManager;
import flixel.math.FlxBasePoint;

public static var nightColor:FlxColor = 0xFF878787;
public static var sunsetColor:FlxColor = 0xFFFF8FB2;

public static var noMiss:Bool = false;

var detailsText:String = '';

var font:String = Paths.font("comic.ttf");
var fontScaler:Int = 1;
var songWatermark:FlxText;
public static var fuckCam:FlxCamera;
var camNoteOffset:Array<Int> = [0,0];
var timeBarText:FlxText;
public static var subtitleManager:SubtitleManager;
final ogFPS = FlxG.drawFramerate;

function setIntroSounds(blah:String){
    introSounds = [blah+'intro3', blah+'intro2', blah+"intro1", blah+"introGo"];
}

function destroy(){
    FlxG.drawFramerate = FlxG.updateFramerate = ogFPS; 
}

PauseSubState.script = 'data/scripts/pause';

function postCreate(){
    switch (FlxG.random.int(0, 5))
    {
        case 0:
            trace("secret dick message ???");
        case 1:
            trace("welcome baldis basics crap");
        case 2:
            trace("Hi, song genie here. You're playing " + SONG.meta.name + ", right?");
        case 3:
            trace('im not doing this dumb dialogue trace shit for a stupid thing nobody cares about');
        case 4:
            trace("suck my balls");
        case 5:
            trace('i hate sick');
        case 6:
            trace('lmao secret message hahahaha you cant get me hahahahah secret message bambi phone do you want do you want phone phone phone phone');
    }

    FlxG.drawFramerate = FlxG.updateFramerate = 144; //for the sake of lerps i guess

    var introSoundsPrefix = '';
    switch (SONG.meta.name.toLowerCase())
    {
        case 'house' | 'insanity' | 'polygonized' | 'bonus song' | 'interdimensional' | 'five nights' |
        'memory' | 'vs dave rap' | 'vs dave rap two':
            introSoundsPrefix = 'introSounds/dave/';
            setIntroSounds(introSoundsPrefix);
        case 'blocked' | 'cheating' | 'corn theft' | 'glitch' | 'maze' | 'mealie' | 'secret' |
        'shredder' | 'supernovae' | 'unfairness':
            introSoundsPrefix = 'introSounds/bambi/';
            setIntroSounds(introSoundsPrefix);
        case 'exploitation':
            introSounds = ['intro3', 'intro2', "intro1", "introSounds/ex/introGo"];
        case 'overdrive':
            introSounds = ['introSounds/dave/intro1', 'introSounds/dave/intro2', "introSounds/dave/intro3", "introSounds/dave/introGo"];
    }


    doIconBop = false;

    camFollow.setPosition(dad.getGraphicMidpoint().x, dad.getGraphicMidpoint().y);
    boyfriend.y -= 350; //boyfriend's global offset in codename is 350 for some reason
    gf.x += 30;
    gf.y += 40;

    fuckCam = new FlxCamera();
    fuckCam.bgColor = 0;

    FlxG.cameras.add(fuckCam, false);

    for(i in [accuracyTxt, missesTxt]){
        i.visible = false;
    }
    
    var healthBarPath = '';
    switch (SONG.meta.name.toLowerCase())
    {
        case 'exploitation':
            healthBarPath = Paths.image('uiShared/healthBars/HELLthBar');
        case 'overdrive':
            healthBarPath = Paths.image('uiShared/healthBars/fnfengine');
        case 'five-nights':
            healthBarPath = Paths.image('uiShared/healthBars/fnafengine');
        default:
            healthBarPath = Paths.image('uiShared/healthBars/healthBar');
    }
    for (i in [scoreTxt, healthBarBG, healthBar, iconP1, iconP2]){
        i.cameras = [fuckCam];
    }
    healthBarBG.loadGraphic(healthBarPath);
    if (Options.downscroll){
        healthBarBG.y = 50;
    }
    healthBar.y = healthBarBG.y + 4;
    remove(healthBar);
    insert(members.indexOf(healthBarBG)-1, healthBar);

    var credits:String = '';

    var creditsText:Bool = credits != '';
    var textYPos:Float = healthBarBG.y + 50;
    if (creditsText)
        textYPos = healthBarBG.y + 30;

    for(icon in [iconP1, iconP2]) {
        icon.y = healthBar.y - (icon.height / 2);
    }

    scoreTxt.setFormat((SONG.meta.name.toLowerCase() == "overdrive") ? Paths.font("ariblk.ttf") : font, 20 * fontScaler, FlxColor.WHITE, 'center', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    scoreTxt.setPosition(healthBarBG.x + healthBarBG.width / 2 - 150, healthBarBG.y + 40);
    scoreTxt.fieldWidth = FlxG.width;
    scoreTxt.borderSize = 1.5 * fontScaler;
    scoreTxt.antialiasing = true;
	scoreTxt.screenCenter(FlxAxes.X);

    songWatermark = new FlxText(4, textYPos, 0, SONG.meta.name, 16);

    songWatermark.setFormat(font, 16 * fontScaler, FlxColor.WHITE, 'center', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    songWatermark.scrollFactor.set();
    songWatermark.borderSize = 1.25 * fontScaler;
    songWatermark.antialiasing = true;
    add(songWatermark); 
    songWatermark.cameras = [fuckCam];

    var yPos = Options.downscroll ? FlxG.height * 0.9 + 20 : strumLine.y - 20;

    songPosBG = new FlxSprite(0, yPos).loadGraphic(Paths.image('uiShared/timerBar'));
    songPosBG.antialiasing = true;
    songPosBG.screenCenter(FlxAxes.X);
    songPosBG.scrollFactor.set();
    add(songPosBG);
    songPosBG.cameras = [fuckCam];
    
    songPosBar = new FlxBar(songPosBG.x + 4, songPosBG.y + 4, FlxBarFillDirection.LEFT_TO_RIGHT, Std.int(songPosBG.width - 8), Std.int(songPosBG.height - 8), 
    Conductor, 'songPosition', 0, inst.length);
    songPosBar.scrollFactor.set();
    songPosBar.createFilledBar(FlxColor.GRAY, FlxColor.fromRGB(57, 255, 20));
    insert(members.indexOf(songPosBG), songPosBar);
    songPosBar.cameras = [fuckCam];

    timeBarText = new FlxText(0, songPosBG.y-13, FlxG.width, "", 32);
    timeBarText.setFormat(font, 32 * fontScaler, FlxColor.WHITE, 'center', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    
    timeBarText.scrollFactor.set();
    timeBarText.borderSize = 2.5 * fontScaler;
    timeBarText.antialiasing = true;
    timeBarText.cameras = [fuckCam];

    add(timeBarText);

    subtitleManager = new SubtitleManager(fuckCam);
    add(subtitleManager);
    add(subtitleManager.fuck);
}

var actualP1dim = [150,150];
var actualP2dim = [150,150];

function beatHit(){
    var funny:Float = Math.max(Math.min(healthBar.value,1.9),0.1);
    
    iconP1.setGraphicSize(Std.int(150 + (50 * (funny + 0.1))),Std.int(150 - (25 * funny)));
    iconP2.setGraphicSize(Std.int(150 + (50 * ((2 - funny) + 0.1))),Std.int(150 - (25 * ((2 - funny) + 0.1))));
    iconP1.updateHitbox();
    iconP2.updateHitbox();
}

function onCountdown(e){
    if(e.swagCounter % 2 == 0 && e.swagCounter != 4) 
        curCameraTarget = 1;
    else{
        curCameraTarget = 0;
    }
}

var scoreTexts:Array<String> = [getTextString('play_score'), getTextString('play_miss'), getTextString('play_accuracy')]; 
//running getTextString on update would be very performance heavy

function postUpdate(e){
    switch (SONG.meta.name.toLowerCase())
    {
        case 'overdrive':
            scoreTxt.text = "score: " + Std.string(songScore);
        case 'exploitation':
            scoreTxt.text = 
            "Scor3: " + (songScore * FlxG.random.int(1,9)) + 
            " | M1ss3s: " + (misses * FlxG.random.int(1,9)) + 
            " | Accuracy: " + (truncateFloat(accuracy, 2) * FlxG.random.int(1,9)) + "% ";
        default:
            scoreTxt.text = 
            scoreTexts[0] + Std.string(songScore) + " | " + 
            scoreTexts[1] + misses +  " | " + 
            scoreTexts[2] + (accuracy < 0 ? '0' : truncateFloat(accuracy*100, 2)) + "%";
            // LanguageManager.getTextString('play_score') + Std.string(songScore) + " | " + 
            // LanguageManager.getTextString('play_miss') + misses +  " | " + 
            // LanguageManager.getTextString('play_accuracy') + truncateFloat(accuracy, 2) + "%";
    }
    if (noMiss)
    {
        scoreTxt.text += " | NO MISS!!";
    }
    fuckCam.zoom = lerp(camHUD.zoom, defaultHudZoom, camHUDZoomLerp);
    
    camFollow.x += camNoteOffset[0];
    camFollow.y += camNoteOffset[1];
}

var thingy = 0.88;

function update(e){
    timeBarText.text = FlxStringUtil.formatTime((inst.length - inst.time) / 1000);

    iconP1.setGraphicSize(Std.int(FlxMath.lerp(150, iconP1.width, thingy)),Std.int(FlxMath.lerp(150, iconP1.height, thingy)));
    iconP1.updateHitbox();

    iconP2.setGraphicSize(Std.int(FlxMath.lerp(150, iconP2.width, thingy)),Std.int(FlxMath.lerp(150, iconP2.height, thingy)));
    iconP2.updateHitbox();
}

function truncateFloat(number:Float, precision:Int):Float
{
    var num = number;
    num = num * Math.pow(10, precision);
    num = Math.round(num) / Math.pow(10, precision);
    return num;
}

function onNoteHit(e){
    switch(e.direction){
        case 0:
            camNoteOffset[0] = -20;
            camNoteOffset[1] = 0;
        case 1:
            camNoteOffset[0] = 0;
            camNoteOffset[1] = 20;
        case 2: 
            camNoteOffset[0] = 0;
            camNoteOffset[1] = -20;
        case 3:
            camNoteOffset[0] = 20;
            camNoteOffset[1] = 0;
        default:
            camNoteOffset[0] = 0;
            camNoteOffset[1] = 0;
    }
}

function onPlayerMiss(e){
    if(noMiss) e.cancel();
}

public static function makeInvisibleNotes(invisible:Bool)
{
    if (invisible)
    {
            FlxTween.cancelTweensOf(camHUD);
            FlxTween.tween(camHUD, {alpha: 0}, 1);
    }
    else
    {
        FlxTween.cancelTweensOf(camHUD);
        FlxTween.tween(camHUD, {alpha: 1}, 1);
    }
}