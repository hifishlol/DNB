public static var leftState:Bool = false;

public static var needVer:String = "IDFK LOL";

public var InExpungedState:Bool = false;

function create(){
    InExpungedState = FlxG.save.data.exploitationState == 'playing';
    var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    add(bg);
    var txt:FlxText = null;
    if (InExpungedState)
    {
        txt = new FlxText(0, 0, FlxG.width, getTextString('intoWarningExpunged'), 32);
        
        FlxG.save.data.exploitationState = null;
        FlxG.save.flush();
    }
    else if (FlxG.save.data.begin_thing)
    {
        txt = new FlxText(0, 0, FlxG.width, getTextString('introWarningSeen'), 32);
    }
    else
    {
        txt = new FlxText(0, 0, FlxG.width, getTextString('introWarningFirstPlay'), 32);
    }
    txt.setFormat("Comic Sans MS Bold", 32, FlxColor.WHITE, 'center');
    txt.screenCenter();
    txt.antialiasing = true;
    add(txt);
}

function update(){
    if (controls.PAUSE && (FlxG.save.data.begin_thing == true || InExpungedState))
    {
        leaveState();
    }
    if (InExpungedState)
    {
        return; //iunno? im not chagning it idk what the intent is
    }
    if (FlxG.keys.justPressed.Y && !FlxG.save.data.begin_thing)
    {
        FlxG.save.data.begin_thing = true;
        FlxG.save.data.eyesores = true;
        leaveState();
    }
    if (FlxG.keys.justPressed.N && !FlxG.save.data.begin_thing)
    {
        FlxG.save.data.begin_thing = true;
        FlxG.save.data.eyesores = false;
        leaveState();	
    }
} 
function leaveState()
{
    if(!FlxG.save.data.alreadyGoneToWarningScreen)
    {
        FlxG.save.data.alreadyGoneToWarningScreen = true;
        FlxG.save.flush();
    }
    leftState = true;
    FlxG.switchState(new MainMenuState());
}