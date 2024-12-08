var bg:FlxSprite = new FlxSprite();
var overlay:FlxSprite = new FlxSprite().loadGraphic(Paths.image('ui/CoolOverlay'));
var selectedFormat:FlxText;
var defaultFormat:FlxText;
var curNameSelected:Int = 0;
var creditsTextGroup:Array<CreditsText> = new Array<CreditsText>();
var menuItems:Array<CreditsText> = new Array<CreditsText>();
var state:State;
var selectedPersonGroup:FlxSpriteGroup = new FlxSpriteGroup();
var selectPersonCam:FlxCamera = new FlxCamera();
var mainCam:FlxCamera = new FlxCamera();
var transitioning:Bool = false;
var creditsTypeString:String = '';
var translatedCreditsType:String = '';

function create(){

}