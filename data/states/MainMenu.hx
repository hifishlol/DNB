import Date;
import flixel.text.FlxText.FlxTextBorderStyle;
import flixel.group.FlxGroup;
import funkin.menus.ModSwitchMenu;
import StringTools;
import flixel.effects.FlxFlicker;
import funkin.options.OptionsMenu;
import funkin.editors.EditorPicker;

var curSelected:Int = 0;
var menuItems:FlxGroup;

var optionShit:Array<String> = 
[
    'story mode', 
    'freeplay', 
    'credits',
    'ost',
    'options',
    'discord'
];

var languagesOptions:Array<String> =
[
    'main_story',
    'main_freeplay',
    'main_credits',
    'main_ost',
    'main_options',
    'main_discord'
];

var languagesDescriptions:Array<String> =
[
    'desc_story',
    'desc_freeplay',
    'desc_credits',
    'desc_ost',
    'desc_options',
    'desc_discord'
];

public static var firstStart:Bool = true;

public static var finishedFunnyMove:Bool = false;

public static var daRealEngineVer:String = 'Dave';
public static var engineVer:String = '3.0b (CNE Port)';

public static var engineVers:Array<String> = 
[
    'Dave', 
    'Bambi', 
    'Tristan'
];

public static var gameVer:String = "0.2.7.1";

var bg:FlxSprite;
var magenta:FlxSprite;
var selectUi:FlxSprite;
var bigIcons:FlxSprite;
var camFollow:FlxObject;
public static var bgPaths:Array<String> = [
    'Aadsta',
    'ArtiztGmer',
    'DeltaKastel',
    'DeltaKastel2',
    'DeltaKastel3',
    'DeltaKastel4',
    'DeltaKastel5',
    'diamond man',
    'Jukebox',
    'kiazu',
    'Lancey',
    'mamakotomi',
    'mantis',
    'mepperpint',
    'morie',
    'neon',
    'Onuko',
    'ps',
    'ricee_png',
    'sk0rbias',
    'SwagnotrllyTheMod',
    'zombought',
];

var logoBl:FlxSprite;

var lilMenuGuy:FlxSprite;

var awaitingExploitation:Bool;
var curOptText:FlxText;
var curOptDesc:FlxText;

// var voidShader:CustomShader; deal with this later

// var prompt:Prompt; deal with this later
var canInteract:Bool = true;

var black:FlxSprite;


function create(){
    awaitingExploitation = (FlxG.save.data.exploitationState == 'awaiting');
    if (!FlxG.sound.music.playing)
    {
        FlxG.sound.playMusic(Paths.music('freakyMenu'));
    }
    persistentUpdate = persistentDraw = true;

    if (awaitingExploitation)
    {
        optionShit = ['freeplay glitch', 'options'];
        languagesOptions = ['main_freeplay_glitch', 'main_options'];
        languagesDescriptions = ['desc_freeplay_glitch', 'desc_options'];
        bg = new FlxSprite(-600, -200).loadGraphic(Paths.image('backgrounds/void/redsky', 'shared'));
        bg.scrollFactor.set(0, 0.2);
        bg.antialiasing = false;
        bg.color = FlxColor.multiply(bg.color, FlxColor.fromRGB(50, 50, 50));
        add(bg);
        
        // #if SHADERS_ENABLED
        // voidShader = new Shaders.GlitchEffect();
        // voidShader.waveAmplitude = 0.1;
        // voidShader.waveFrequency = 5;
        // voidShader.waveSpeed = 2;
        
        // bg.shader = voidShader.shader;
        // #end

        magenta = new FlxSprite(-600, -200).loadGraphic(bg.graphic);
        magenta.scrollFactor.set();
        magenta.antialiasing = false;
        magenta.visible = false;
        magenta.color = FlxColor.multiply(0xFFfd719b, FlxColor.fromRGB(50, 50, 50));
        add(magenta);

        // #if SHADERS_ENABLED
        // magenta.shader = voidShader.shader;
        // #end
    }
    else
    {
        bg = new FlxSprite(-80).loadGraphic(randomizeBG());
        bg.scrollFactor.set();
        bg.setGraphicSize(Std.int(bg.width * 1.1));
        bg.updateHitbox();
        bg.screenCenter();
        bg.antialiasing = true;
        bg.color = 0xFFFDE871;
        add(bg);

        magenta = new FlxSprite(-80).loadGraphic(bg.graphic);
        magenta.scrollFactor.set();
        magenta.setGraphicSize(Std.int(magenta.width * 1.1));
        magenta.updateHitbox();
        magenta.screenCenter();
        magenta.visible = false;
        magenta.antialiasing = true;
        magenta.color = 0xFFfd719b;
        add(magenta);
    }

    selectUi = new FlxSprite(0, 0).loadGraphic(Paths.image('mainMenu/Select_Thing'));
    selectUi.scrollFactor.set(0, 0);
    selectUi.antialiasing = true;
    selectUi.updateHitbox();
    add(selectUi);

    bigIcons = new FlxSprite(0, 0);
    bigIcons.frames = Paths.getSparrowAtlas('ui/menu_big_icons');
    for (i in 0...optionShit.length)
    {
        bigIcons.animation.addByPrefix(optionShit[i], optionShit[i] == 'freeplay' ? 'freeplay0' : optionShit[i], 24);
    }
    bigIcons.scrollFactor.set(0, 0);
    bigIcons.antialiasing = true;
    bigIcons.updateHitbox();
    bigIcons.animation.play(optionShit[0]);
    bigIcons.screenCenter(FlxAxes.X);
    add(bigIcons);

    curOptText = new FlxText(0, 0, FlxG.width, formatString(getTextString(languagesOptions[curSelected]), ' '));
    // curOptText = new FlxText(0, 0, FlxG.width, CoolUtil.formatString(getTextString(languagesOptions[curSelected]), ' '));
    curOptText.setFormat(Paths.getFontName(Paths.font('comic.ttf')), 48, FlxColor.WHITE, 'center', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    curOptText.scrollFactor.set(0, 0);
    curOptText.borderSize = 2.5;
    curOptText.antialiasing = true;
    curOptText.screenCenter(FlxAxes.X);
    curOptText.y = FlxG.height / 2 + 28;
    add(curOptText);

    curOptDesc = new FlxText(0, 0, FlxG.width, getTextString(languagesDescriptions[curSelected]));
    curOptDesc.setFormat(Paths.getFontName(Paths.font('comic.ttf')), 24, FlxColor.WHITE, 'center', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    curOptDesc.scrollFactor.set(0, 0);
    curOptDesc.borderSize = 2;
    curOptDesc.antialiasing = true;
    curOptDesc.screenCenter(FlxAxes.X);
    curOptDesc.y = FlxG.height - 58;
    add(curOptDesc);

    menuItems = new FlxGroup();
    add(menuItems);

    var tex = Paths.getSparrowAtlas('ui/main_menu_icons');

    for (i in 0...optionShit.length)
    {
        var currentOptionShit = optionShit[i];
        var menuItem:FlxSprite = new FlxSprite(FlxG.width * 1.6, 0);
        menuItem.frames = tex;
        menuItem.animation.addByPrefix('idle', (currentOptionShit == 'freeplay glitch' ? 'freeplay' : currentOptionShit) + " basic", 24);
        menuItem.animation.addByPrefix('selected', (currentOptionShit == 'freeplay glitch' ? 'freeplay' : currentOptionShit) + " white", 24);
        menuItem.animation.play('idle');
        menuItem.antialiasing = false;
        menuItem.setGraphicSize(128, 128);
        menuItem.ID = i;
        menuItem.updateHitbox();
        //menuItem.screenCenter(Y);
        //menuItem.alpha = 0; //TESTING
        menuItems.add(menuItem);
        menuItem.scrollFactor.set(0, 1);
        if (firstStart)
        {
            FlxTween.tween(menuItem, {x: FlxG.width / 2 - 450 + (i * 160)}, 1 + (i * 0.25), {
                ease: FlxEase.expoInOut,
                onComplete: function(flxTween:FlxTween)
                {
                    finishedFunnyMove = true;
                    //menuItem.screenCenter(Y);
                    changeItem(0);
                }
            });
        }
        else
        {
            //menuItem.screenCenter(Y);
            menuItem.x = FlxG.width / 2 - 450 + (i * 160);
            changeItem(0);
        }
    }

    firstStart = false;

    var versionShit:FlxText = new FlxText(1, FlxG.height - 25, 0, daRealEngineVer+' Engine v'+engineVer+'\nFNF v'+gameVer, 12);
    versionShit.antialiasing = true;
    versionShit.scrollFactor.set();
    versionShit.setFormat(Paths.getFontName(Paths.font('comic.ttf')), 16, FlxColor.WHITE, 'left', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    add(versionShit);

    menuItems.forEach(function(spr:FlxSprite)
    {
        spr.y = FlxG.height / 2 + 130;
    });

    // NG.core.calls.event.logEvent('swag').send();
}

function changeItem(huh:Int = 0)
{
    if (finishedFunnyMove)
    {
        curSelected += huh;

        if (curSelected >= menuItems.length)
            curSelected = 0;
        if (curSelected < 0)
            curSelected = menuItems.length - 1;
    }

    menuItems.forEach(function(spr:FlxSprite)
    {
        if(finishedFunnyMove){
            if (spr.ID == curSelected)
            {
                spr.animation.play('selected');
                //camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
            }else{
                spr.animation.play('idle');
            }
        }
        
        //spr.screenCenter(Y);
        spr.updateHitbox();
    });

    bigIcons.animation.play(optionShit[curSelected]);
    curOptText.text = formatString(getTextString(languagesOptions[curSelected]), ' ');
    curOptDesc.text = getTextString(languagesDescriptions[curSelected]);
}

function randomizeBG()
{
    var date = Date.now();
    var chance:Int = FlxG.random.int(0, bgPaths.length - 1);
    if(date.getMonth() == 3 && date.getDate() == 1)
    {
        return Paths.image('menuBGs/ramzgaming');
    }
    else
    {
        return Paths.image('menuBGs/'+bgPaths[chance]);
    }
}

function formatString(string:String, separator:String)
{
    var split:Array<String> = string.split(separator);
    var formattedString:String = '';
    for (i in 0...split.length)
    {
        var piece:String = split[i];
        var allSplit = piece.split('');
        var firstLetterUpperCased = allSplit[0].toUpperCase();
        var substring = piece.substr(1, piece.length - 1);
        var newPiece = firstLetterUpperCased + substring;
        if (i != split.length - 1)
        {
            newPiece += " ";
        }
        formattedString += newPiece;
    }
    return formattedString;
}

var selectedSomethin:Bool = false;

function update(){
    if (controls.SWITCHMOD) {
        openSubState(new ModSwitchMenu());
        persistentUpdate = false;
        persistentDraw = true;
    }
    if (FlxG.sound.music != null && FlxG.sound.music.volume < 0.8)
    {
        FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
    }
    if (canInteract)
    {
        if (FlxG.keys.justPressed.SEVEN)
        {
            if(FlxG.keys.pressed.SHIFT){
                persistentUpdate = false;
                persistentDraw = true;
                openSubState(new EditorPicker());
            }else{
                var deathSound:FlxSound = new FlxSound();
                deathSound.loadEmbedded(Paths.soundRandom('missnote', 1, 3));
                deathSound.volume = FlxG.random.float(0.6, 1);
                deathSound.play();
                
                FlxG.camera.shake(0.05, 0.1);
            }
        }
    }
    if (!selectedSomethin && canInteract)
    {
        if (controls.LEFT_P)
        {
            FlxG.sound.play(Paths.sound('menu/scroll'));
            changeItem(-1);
        }

        if (controls.RIGHT_P)
        {
            FlxG.sound.play(Paths.sound('menu/scroll'));
            changeItem(1);
        }

        if (controls.BACK)
        {
            FlxG.switchState(new TitleState());
        }

        if (controls.ACCEPT)
        {
            if (optionShit[curSelected] == 'discord' || optionShit[curSelected] == 'merch')
            {
                switch (optionShit[curSelected])
                {
                    case 'discord':
                        CoolUtil.openURL("https://www.discord.gg/vsdave");
                }
            }
            else
            {
                selectedSomethin = true;
                FlxG.sound.play(Paths.sound('menu/confirm'));

                FlxFlicker.flicker(magenta, 1.1, 0.15, false);

                menuItems.forEach(function(spr:FlxSprite)
                {
                    if (curSelected != spr.ID)
                    {
                        FlxTween.tween(spr, {alpha: 0}, 1.3, {
                            ease: FlxEase.quadOut,
                            onComplete: function(twn:FlxTween)
                            {
                                spr.kill();
                            }
                        });
                    }
                    else
                    {
                        FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
                        {
                            var daChoice:String = optionShit[curSelected];
                            switch (daChoice)
                            {
                                case 'story mode':
                                    FlxG.switchState(new StoryMenuState());
                                case 'freeplay' | 'freeplay glitch':
                                    if (FlxG.random.bool(0.05))
                                    {
                                        CoolUtil.openURL("https://www.youtube.com/watch?v=Z7wWa1G9_30%22");
                                    }
                                    FlxG.switchState(new FreeplayState());
                                case 'options':
                                    FlxG.switchState(new OptionsMenu());
                                case 'ost':
                                    FlxG.switchState(new MusicPlayerState());
                                case 'credits':
                                    FlxG.switchState(new ModState('CreditsMenu'));
                            }
                        });
                    }
                });
            }
        }
    }
}