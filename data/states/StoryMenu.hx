import funkin.savedata.FunkinSave;
import hxvlc.flixel.FlxVideoSprite;

var scoreText:FlxText;

public static var weekUnlocked:Array<Bool> = [true, true, true, true, true, true];

var txtWeekTitle:FlxText;

var curWeek:Int = 0;

var yellowBG:FlxSprite;

var txtTracklist:FlxText;
var txtTrackdeco:FlxText;

var grpWeekText:FlxGroup;

var grpLocks:FlxGroup;

var weeks:Array = [
    {songList: ['Warmup'], weekName: getTextString('story_tutorial'), weekColor: 0xFF8A42B7, bannerName: 'warmup', id: 'warmup'},
    {songList: ['House', 'Insanity', 'Polygonized'], weekName: getTextString('story_daveWeek'), weekColor: 0xFF4965FF, bannerName: 'DaveHouse', id: 'dave'},
    {songList: ['Blocked', 'Corn-Theft', 'Maze'], weekName: getTextString('story_bambiWeek'), weekColor: 0xFF00B515, bannerName: 'bamboi', id: 'bambi'},
    {songList: ['Splitathon'], weekName: getTextString('story_finale'), weekColor: 0xFF00FFFF, bannerName: 'splitathon', id: 'splitathon'},
    {songList: ['Shredder', 'Greetings', 'Interdimensional', 'Rano'], weekName: getTextString('story_festivalWeek'), weekColor: 0xFF800080, bannerName: 'festival', id: 'festival'},
];

static var awaitingToPlayMasterWeek:Bool;

var weekBanners:Array = [new FlxSprite()];
var lastSelectedWeek:Int = 0;

function create(){
    if (FlxG.save.data.masterWeekUnlocked)
    {
        var weekName = !FlxG.save.data.hasPlayedMasterWeek ? getTextString('story_masterWeekToPlay') : getTextString('story_masterWeek');
        weeks.push({songList: ['Supernovae', 'Glitch', 'Master'], weekName: weekName, weekColor: 0xFF116E1C, bannerName: FlxG.save.data.hasPlayedMasterWeek ? 'masterweek' : 'masterweekquestion'});  // MASTERA BAMBI
    }

    if (FlxG.sound.music != null)
    {
        if (!FlxG.sound.music.playing)
            FlxG.sound.playMusic(Paths.music('freakyMenu'));
    }

    persistentUpdate = persistentDraw = true;

    scoreText = new FlxText(10, 0, 0, "SCORE: 49324858", 36);
    scoreText.setFormat(Paths.getFontName(Paths.font('comic.ttf')), 32);
    scoreText.antialiasing = true;

    txtWeekTitle = new FlxText(FlxG.width * 0.7, 0, 0, "", 32);
    txtWeekTitle.setFormat(Paths.getFontName(Paths.font('comic.ttf')), 32, FlxColor.WHITE, 'right');
    txtWeekTitle.antialiasing = true;
    txtWeekTitle.alpha = 0.7;

    var rankText:FlxText = new FlxText(0, 10);
    rankText.text = 'RANK: GREAT';
    rankText.setFormat(Paths.font("comic.ttf"), 32);
    rankText.antialiasing = true;
    rankText.size = scoreText.size;
    rankText.screenCenter(FlxAxes.X);

    yellowBG = new FlxSprite(0, 56).makeSolid(FlxG.width * 2, 400, FlxColor.WHITE);
    yellowBG.color = weeks[0].weekColor;

    grpWeekText = new FlxGroup();
    add(grpWeekText);

    var blackBarThingie:FlxSprite = new FlxSprite().makeSolid(FlxG.width, 57, FlxColor.BLACK);
    add(blackBarThingie);

    grpLocks = new FlxGroup();
    add(grpLocks);

    for (i in 0...weeks.length)
    {
        var weekThing:MenuItem = new MenuItem(0, yellowBG.y + yellowBG.height + 80, null, i);
        weekThing.x += ((weekThing.width + 20) * i);
        weekThing.targetX = i;
        weekThing.antialiasing = true;
        grpWeekText.add(weekThing);
    }

    add(yellowBG);

    txtTrackdeco = new FlxText(0, yellowBG.x + yellowBG.height + 50, FlxG.width, getTextString('story_track').toUpperCase(), 28);
    txtTrackdeco.alignment = 'center';
    txtTrackdeco.font = rankText.font;
    txtTrackdeco.color = 0xFFe55777;
    txtTrackdeco.antialiasing = true;
    txtTrackdeco.screenCenter(FlxAxes.X);

    txtTracklist = new FlxText(0, yellowBG.x + yellowBG.height + 80, FlxG.width, '', 28);
    txtTracklist.alignment = 'center';
    txtTracklist.font = rankText.font;
    txtTracklist.color = 0xFFe55777;
    txtTracklist.antialiasing = true;
    txtTracklist.screenCenter(FlxAxes.X);
    add(txtTrackdeco);
    add(txtTracklist);
    add(scoreText);
    add(txtWeekTitle);

    weekBanners = [];

    for (i in 0...weeks.length)
    {
        var weekBanner:FlxSprite = new FlxSprite(600, 56).loadGraphic(Paths.image('weekBanners/'+weeks[i].bannerName));
        weekBanner.antialiasing = false;
        weekBanner.active = true;
        weekBanner.screenCenter(FlxAxes.X);
        weekBanner.alpha = i == curWeek ? 1 : 0;
        add(weekBanner);

        weekBanners.push(weekBanner);
    }

    updateText();
    
    if (awaitingToPlayMasterWeek)
    {
        awaitingToPlayMasterWeek = false;
        changeWeek(5 - curWeek);
    }
    else
    {
        changeWeek(0);
    }
}

var lerpScore:Int = 0;
var intendedScore:Int = 0;
var languageWeekScore = getTextString('story_weekScore'); //no performance issues!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

var movedBack:Bool = false;
var selectedWeek:Bool = false;
var stopspamming:Bool = false;

function update(elapsed){
    lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, 0.5));

    scoreText.text = languageWeekScore + lerpScore;
    txtWeekTitle.text = weeks[curWeek].weekName.toUpperCase();
    txtWeekTitle.x = FlxG.width - (txtWeekTitle.width + 10);

    // FlxG.watch.addQuick('font', scoreText.font);
    
    if (!movedBack)
    {
        if (!selectedWeek)
        {
            if (controls.LEFT_P)
            {
                changeWeek(-1);
            }

            if (controls.RIGHT_P)
            {
                changeWeek(1);
            }
        }

        if (controls.ACCEPT)
        {
            selectWeek();
            if(video != null){
                video.destroy();
                FlxG.switchState(new PlayState());
            }
        }
    }

    if (controls.BACK && !movedBack && !selectedWeek)
    {
        FlxG.sound.play(Paths.sound('menu/cancel'));
        movedBack = true;
        FlxG.switchState(new MainMenuState());
    }
    if (FlxG.keys.justPressed.SEVEN && !FlxG.save.data.masterWeekUnlocked)
    {
        FlxG.sound.music.fadeOut(1, 0);
        FlxG.camera.shake(0.02, 5.1);
        FlxG.camera.fade(FlxColor.WHITE, 5.05, false, function()
        {
            FlxG.save.data.masterWeekUnlocked = true;
            FlxG.save.data.hasPlayedMasterWeek = false;
            awaitingToPlayMasterWeek = true;
            FlxG.save.flush();

            FlxG.resetState();
        });
        FlxG.sound.play(Paths.sound('doom'));
    }
}

function updateText()
{
    txtTracklist.text = "";

    var stringThing:Array<String> = weeks[curWeek].songList;

    if (curWeek == 5 && !FlxG.save.data.hasPlayedMasterWeek)
    {
        stringThing = ['???', '???', '???'];
    }

    for (i in stringThing)
    {
        //txtTracklist.text += " - " + i;

    }

    txtTracklist.text = stringThing.join(' - ');

    //txtTracklist.text = txtTracklist.text += " - ";

    intendedScore = FunkinSave.getWeekHighscore(weeks[curWeek].id, 'normal');

    //like im not even gonna ask about this code im just gonna copy and paste it
}

function changeWeek(change:Int = 0):Void
{
    lastSelectedWeek = curWeek;
    curWeek += change;

    if (curWeek > weeks.length - 1)
        curWeek = 0;
    if (curWeek < 0)
        curWeek = weeks.length - 1;
    
    var bullShit:Int = 0;
    
    for (item in grpWeekText.members)
    {
        item.targetX = bullShit - curWeek;
        if (item.targetX == Std.int(0) && weekUnlocked[curWeek])
            item.alpha = 1;
        else
            item.alpha = 0.6;
        bullShit++;
    }

    FlxTween.color(yellowBG, 0.25, yellowBG.color, weeks[curWeek].weekColor);

    FlxG.sound.play(Paths.sound('menu/scroll'));

    updateText();
    updateWeekBanner();
}

function updateWeekBanner()
{
    for (i in 0...weekBanners.length)
    {
        if (![lastSelectedWeek, curWeek].contains(i))
        {
            weekBanners[i].alpha = 0;
        }
    }
    FlxTween.tween(weekBanners[lastSelectedWeek], {alpha: 0}, 0.1);
    FlxTween.tween(weekBanners[curWeek], {alpha: 1}, 0.1);
}

var video:FlxVideoSprite; //daveeee

function selectWeek()
{
    if(stopspamming) return;
    if (weekUnlocked[curWeek])
    {
        if (!stopspamming)
        {
            FlxG.sound.play(Paths.sound('menu/confirm'));

            grpWeekText.members[curWeek].startFlashing();
            stopspamming = true;
        }
        
        var songArrayNames:Array<String> = [for (song in weeks[curWeek].songList) song.toLowerCase()]; //grab the name list
        
        var songArray:Array<WeekSong> = []; //convert to weeksong format
        for (song in songArrayNames){
            songArray.push({name: song, hide: false});
        }

        PlayState.loadWeek({
            name: weeks[curWeek].id,
            id: weeks[curWeek].id,
            sprite: null,
            chars: [null, null, null],
            songs: songArray,
            difficulties: ['normal']
        }, "normal");
        PlayState.isStoryMode = true;
        selectedWeek = true;

        new FlxTimer().start(1, function(tmr:FlxTimer)
        {
            PlayState.characteroverride = "none";
            PlayState.formoverride = "none";
            PlayState.curmult = [1, 1, 1, 1];
            
            switch (curWeek)
            {
                case 1:
                    FlxG.sound.music.stop();
                    video = new FlxVideoSprite();
                    video.load(Assets.getPath(Paths.file("videos/daveCutscene.mp4")));
                    add(video);
                    video.bitmap.onEndReached.add(function() {
                        video.destroy(); 
                        FlxG.switchState(new PlayState());
                        trace("vid complete");
                    });
                    video.play();
                case 5:
                    if (!FlxG.save.data.hasPlayedMasterWeek)
                    {
                        FlxG.save.data.hasPlayedMasterWeek = true;
                        FlxG.save.flush();
                    }
                    FlxG.switchState(new PlayState());
                default:
                    FlxG.switchState(new PlayState());
            }
        });
    }
}

class MenuItem extends FlxSprite
{
	public var targetX:Float = 0;
    public var week:FlxSprite;

	public function new(x:Float, y:Float, FUCK, weekNum:Int = 0) //Removing that bitmap error by making it so what would originally be "SimpleGraphic" can just be set as null
	{
		super(x, y);
        if (weekNum == 5 && !FlxG.save.data.hasPlayedMasterWeek)
        {
            loadGraphic(Paths.image('storymenu/weekquestionmark'));
        }
        else
        {
            loadGraphic(Paths.image('storymenu/week' + weekNum));
        }
		antialiasing = true;
	}

	private var isFlashing:Bool = false;

	public function startFlashing():Void
	{
		isFlashing = true;
	}

    public var time:Float = 0;

	override function update(elapsed:Float)
	{
		super.update(elapsed);
        time += elapsed;
		x = CoolUtil.fpsLerp(x, (targetX * 450) + 420, 0.17);

		if (isFlashing)
			color = (time % 0.1 > 0.05) ? FlxColor.WHITE : 0xFF33ffff;
	}
}

//house shit

function focusGained(){
    if (video != null)
        video.pause(); 
}
function focusLost(){
    if (video != null)
        video.pause(); 
}