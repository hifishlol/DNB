import Date;

function postCreate(){
    members[0].loadGraphic(randomizeBG());
    members[0].color = 0xFF9271fd;
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