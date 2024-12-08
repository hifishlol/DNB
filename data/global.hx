import openfl.text.TextFormatAlign;
import openfl.text.TextFormat; 
import funkin.backend.system.framerate.Framerate;
import funkin.backend.utils.WindowUtils;
import StringTools;
import funkin.backend.MusicBeatState;

static var seenSplash:Bool = false;

var redirectStates:Map<FlxState, String> = [
    MainMenuState => "MainMenu",
    StoryMenuState => "StoryMenu",
];

function preStateSwitch() {
    if (!seenSplash){
        seenSplash = true;
        MusicBeatState.skipTransIn = MusicBeatState.skipTransOut = true;
        FlxG.switchState(new ModState('Splash'));
    }
    for (redirectState in redirectStates.keys())
        if (Std.isOfType(FlxG.game._requestedState, redirectState))
            FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
}

//soundtray+fps

final ogDtfs:Array<TextFormat> = [FlxG.game.soundTray.text.defaultTextFormat, 
    Framerate.fpsCounter.fpsNum.defaultTextFormat, 
    Framerate.fpsCounter.fpsLabel.defaultTextFormat,
    Framerate.memoryCounter.memoryText.defaultTextFormat,
    Framerate.memoryCounter.memoryPeakText.defaultTextFormat,
    Framerate.codenameBuildField.defaultTextFormat
];

var theDtf:TextFormat = new TextFormat(Paths.getFontName(Paths.font("comic.ttf")), 8, 0xffffff);
theDtf.align = TextFormatAlign.CENTER;
FlxG.game.soundTray.text.defaultTextFormat = theDtf;
// FlxG.game.soundTray.volumeChangeSFX = Paths.sound('clicky'); ig its not possible
function update(){
    FlxG.game.soundTray.text.text = "Volume - " + (Math.round(FlxG.sound.volume * 10)) * 10 + "%";
}

theDtf.size = 16;

Framerate.fpsCounter.fpsNum.defaultTextFormat = theDtf;
Framerate.fpsCounter.fpsLabel.defaultTextFormat = theDtf;
Framerate.memoryCounter.memoryText.defaultTextFormat = theDtf;
Framerate.memoryCounter.memoryPeakText.defaultTextFormat = theDtf;
Framerate.codenameBuildField.defaultTextFormat = theDtf;

function destroy(){
    FlxG.game.soundTray.text.defaultTextFormat = ogDtfs[0];
    Framerate.fpsCounter.fpsNum.defaultTextFormat = ogDtfs[1];
    Framerate.fpsCounter.fpsLabel.defaultTextFormat = ogDtfs[2];
    Framerate.memoryCounter.memoryText.defaultTextFormat = ogDtfs[3];
    Framerate.memoryCounter.memoryPeakText.defaultTextFormat = ogDtfs[4];
    Framerate.codenameBuildField.defaultTextFormat = ogDtfs[5]; //"theres probably a better way of doing this" Shhhhhhhh

    FlxG.game.soundTray.text.text = "VOLUME";
}

var icon:Image = Paths.assetsTree.getAsset('assets/appIcons/dave.png', 'IMAGE');
Application.current.window.setIcon(icon);

WindowUtils.winTitle = "Friday Night Funkin' | VS. Dave and Bambi 3.0";

FlxG.save.data.language ??= 'en-US';
FlxG.save.data.hasSeenSplash ??= false;

//languaaaaage manaaaager

public static var currentLocaleList:Array<String>;
public static var currentTerminalList:Array<String>; // terminal locale

currentLocaleList = CoolUtil.coolTextFile(Paths.file('locale/' + FlxG.save.data.language + '/textList.txt'));
currentTerminalList = CoolUtil.coolTextFile(Paths.file('locale/' + FlxG.save.data.language + '/terminalList.txt'));

public static function getTextString(stringName:String)
{
    var returnedString:String = '';
    for (i in 0...currentLocaleList.length)
    {
        var currentValue = currentLocaleList[i].split('==');
        // currentValue = currentValue.split('==');
        if (currentValue[0] != stringName)
        {
            continue;
        }
        else
        {
            returnedString = currentValue[1];
        }
    }
    if (returnedString == '')
    {
        return stringName;
    }
    else
    {
        returnedString = StringTools.replace(returnedString, ':linebreak:', '\n');
        returnedString = StringTools.replace(returnedString, ':addquote:', '\"');
        return returnedString;
    }
}

function isLocale():Bool
{
    if (FlxG.save.data.language != 'en-US')
    {
        return true;
    }
    return false;
}

public static function dnbFile(file:String, ?library:String)
{
    var defaultReturnPath = Paths.getPath(file, library);
    if (isLocale())
    {
        var langaugeReturnPath = getPath('locale/'+FlxG.save.data.language+'/'+ file, library);
        if (FileSystem.exists(langaugeReturnPath))
        {
            return langaugeReturnPath;
        }
        else
        {
            return defaultReturnPath;
        }
    }
    else
    {
        return defaultReturnPath;
    }
}

public static function dnbImage(key:String, ?library:String)
{
    var defaultReturnPath = Paths.image(key, library);
    if (isLocale())
    {
        var langaugeReturnPath = getPath('locale/'+FlxG.save.data.language+'/images/'+key+'.png', library);
        if (FileSystem.exists(langaugeReturnPath))
        {
            return langaugeReturnPath;
        }
        else
        {
            return defaultReturnPath;
        }
    }
    else
    {
        return defaultReturnPath;
    }
}

public static function getMinAndMax(value1:Float, value2:Float)
{
    var min = Math.min(value1, value2);
    var max = Math.max(value1, value2);

    var minAndMaxs:Array = [min, max];
    
    return minAndMaxs;
}

public static function getBackgroundColor(stage:String)
{
    var variantColor:FlxColor = FlxColor.WHITE;
    switch (stage)
    {
        case 'night':
            variantColor = nightColor;
        case 'sunset':
            variantColor = sunsetColor;
        default:
            variantColor = FlxColor.WHITE;
    }
    return variantColor;
}