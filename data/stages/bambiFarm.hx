var sunsetBG:FunkinSprite;
var nightBG:FunkinSprite; //fucking fuck

function create(){
    dad.x += 200;
    dad.y += 340;
    boyfriend.y += 340;
    gf.x += 30;

    var skyType = (PlayState.SONG.meta.customValues?.skyType ?? 'sky');

    var bg:FunkinSprite = new FunkinSprite(-600, -200, Paths.image('backgrounds/shared/'+skyType));
    bg.scrollFactor.set(0.6,0.6);
    insert(0, bg);

    if (SONG.meta.name.toLowerCase() == 'maze')
    {
        sunsetBG = new FunkinSprite(-600, -200, Paths.image('backgrounds/shared/sky_sunset'));
        sunsetBG.scrollFactor.set(0.6, 0.6);
        sunsetBG.alpha = 0;
        insert(1, sunsetBG);

        nightBG = new FunkinSprite(-600, -200, Paths.image('backgrounds/shared/sky_night'));
        nightBG.scrollFactor.set(0.6, 0.6);
        nightBG.alpha = 0;
        insert(2, nightBG);
        if (PlayState.isStoryMode)
        {
            health -= 0.2;
        }
    }
    
    var flatgrass:FunkinSprite = new FunkinSprite(350, 75, Paths.image('backgrounds/farm/gm_flatgrass'));
    flatgrass.scrollFactor.set(0.65, 0.65);
    flatgrass.setGraphicSize(Std.int(flatgrass.width * 0.34));
    flatgrass.updateHitbox();
    
    var hills:FunkinSprite = new FunkinSprite(-173, 100, Paths.image('backgrounds/farm/orangey hills'));
    hills.scrollFactor.set(0.65, 0.65);
    
    var farmHouse:FunkinSprite = new FunkinSprite(100, 125, Paths.image('backgrounds/farm/funfarmhouse'));
    farmHouse.scrollFactor.set(0.7, 0.7);
    farmHouse.setGraphicSize(Std.int(farmHouse.width * 0.9));
    farmHouse.updateHitbox();

    var grassLand:FunkinSprite = new FunkinSprite(-600, 500, Paths.image('backgrounds/farm/grass lands'));

    var cornFence:FunkinSprite = new FunkinSprite(-400, 200, Paths.image('backgrounds/farm/cornFence'));
    
    var cornFence2:FunkinSprite = new FunkinSprite(1100, 200, Paths.image('backgrounds/farm/cornFence2'));

    var bagType = FlxG.random.int(0, 1000) == 0 ? 'popeye' : 'cornbag';
    var cornBag:FunkinSprite = new FunkinSprite(1200, 550, Paths.image('backgrounds/farm/'+bagType));
    
    var sign:FunkinSprite = new FunkinSprite(0, 350, Paths.image('backgrounds/farm/sign'));

    var backgroundSprites:Array<FlxSprite> = [flatgrass,hills,farmHouse,grassLand,cornFence,cornFence2,cornBag,sign];

    var offset:Int = ((SONG.meta.name.toLowerCase() == 'maze') ? 3 : 1);

    for(i=>idk in backgroundSprites){
        insert(i+offset, idk);
    }

    var variantColor:FlxColor = getBackgroundColor(skyType);

    for(i in backgroundSprites) i.color = variantColor;
    // flatgrass.color = variantColor;
    // hills.color = variantColor;
    // farmHouse.color = variantColor;
    // grassLand.color = variantColor;
    // cornFence.color = variantColor;
    // cornFence2.color = variantColor;
    // cornBag.color = variantColor;
    // sign.color = variantColor;

    if (['blocked', 'corn-theft', 'maze', 'mealie', 'indignancy'].contains(SONG.meta.name.toLowerCase()) /*&& !MathGameState.failedGame for now*/ && FlxG.random.int(0, 4) == 0)
    {
        FlxG.mouse.visible = true;
        baldi = new FunkinSprite(400, 110, Paths.image('backgrounds/farm/baldo'));
        baldi.scrollFactor.set(0.65, 0.65);
        baldi.setGraphicSize(Std.int(baldi.width * 0.31));
        baldi.updateHitbox();
        baldi.color = variantColor;
        backgroundSprites.push(baldi);
        insert(members.indexOf(hills), baldi);
    }

    if (SONG.meta.name.toLowerCase() == 'splitathon')
    {
        var picnic:BGSprite = new BGSprite('picnic', 1050, 650, Paths.image('backgrounds/farm/picnic_towel_thing', 'shared'), null);
        sprites.insert(sprites.members.indexOf(cornBag), picnic);
        picnic.color = variantColor;
        insert(members.indexOf(cornBag), picnic);
    }

    if (SONG.meta.name.toLowerCase() == 'maze'){
        backgroundSprites = [bg,sunsetBG,nightBG,flatgrass,hills,farmHouse,grassLand,cornFence,cornFence2,cornBag,sign];
        var tweenTime = Conductor.crochet*4*24; //huh
        for (i in 0...backgroundSprites.length)
        {
            var bgSprite = backgroundSprites[i];
            var tween:FlxTween = null;
            switch (i)
            {
                case 0:
                    tween = FlxTween.tween(bgSprite, {alpha: 0}, tweenTime / 1000);
                case 1:
                    tween = FlxTween.tween(bgSprite, {alpha: 1}, tweenTime / 1000).then(FlxTween.tween(bgSprite, {alpha: 0}, tweenTime / 1000));
                case 2:
                    tween = FlxTween.tween(bgSprite, {alpha: 0}, tweenTime / 1000).then(FlxTween.tween(bgSprite, {alpha: 1}, tweenTime / 1000));
                default:
                    tween = FlxTween.color(bgSprite, tweenTime / 1000, FlxColor.WHITE, sunsetColor).then(
                        FlxTween.color(bgSprite, tweenTime / 1000, sunsetColor, nightColor)
                        );
            }
        }
        var gfTween = FlxTween.color(gf, tweenTime / 1000, FlxColor.WHITE, sunsetColor).then(FlxTween.color(gf, tweenTime / 1000, sunsetColor, nightColor));
        var bambiTween = FlxTween.color(dad, tweenTime / 1000, FlxColor.WHITE, sunsetColor).then(FlxTween.color(dad, tweenTime / 1000, sunsetColor, nightColor));
        bfTween = FlxTween.color(boyfriend, tweenTime / 1000, FlxColor.WHITE, sunsetColor, {
            onComplete: function(tween:FlxTween)
            {
                bfTween = FlxTween.color(boyfriend, tweenTime / 1000, sunsetColor, nightColor);
            }
        });
    }
}