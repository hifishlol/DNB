function create(){

    var bg:FunkinSprite = new FunkinSprite(-600, -300, Paths.image('backgrounds/shared/'+(PlayState.SONG.meta.customValues?.skyType ?? 'sky')));
    bg.scrollFactor.set(0.6,0.6);
    insert(0, bg);
    
    var stageHills:FunkinSprite = new FunkinSprite(-834, -159, Paths.image('backgrounds/dave-house/'+(PlayState.SONG.meta.customValues?.assetType ?? '')+'hills'));
    stageHills.scrollFactor.set(0.7,0.7);
    insert(1, stageHills);

    var grassbg:FunkinSprite = new FunkinSprite(-1205, 580, Paths.image('backgrounds/dave-house/'+(PlayState.SONG.meta.customValues?.assetType ?? '')+'grass bg'));
    insert(2, grassbg);

    var gate:FunkinSprite = new FunkinSprite(-755, 250, Paths.image('backgrounds/dave-house/'+(PlayState.SONG.meta.customValues?.assetType ?? '')+'gate'));
    insert(3, gate);

    var stageFront:FunkinSprite = new FunkinSprite(-832, 505, Paths.image('backgrounds/dave-house/'+(PlayState.SONG.meta.customValues?.assetType ?? '')+'grass'));
    insert(4, stageFront);
}