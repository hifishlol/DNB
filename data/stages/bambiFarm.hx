function create(){
    dad.x += 200;
    dad.y += 340;
    boyfriend.y += 340;
    gf.x += 30;

    var bg:FunkinSprite = new FunkinSprite(-600, -200, Paths.image('backgrounds/shared/'+(PlayState.SONG.meta.customValues?.skyType ?? 'sky')));
    bg.scrollFactor.set(0.6,0.6);
    insert(0, bg);
    
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

    for(i=>idk in [flatgrass, hills, farmHouse, grassLand, cornFence, cornFence2, cornBag, sign]){
        insert(i+1, idk);
    }
}