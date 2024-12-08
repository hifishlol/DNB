class SubtitleManager
{
    public var fuck:FlxGroup = new FlxGroup();
    public function new(camera:FlxCamera){
        fuck.cameras = [camera];
    }
    public function addSubtitle(text:String, ?typeSpeed:Float, showTime:Float, subtitleSize:Int = 36)
    {
        if(subtitleSize == 1 || subtitleSize == null) subtitleSize = 36; //for some reason if it isnt defined, the size is 1? even tho it defaults to 36 if its not defined??
		var subtitle = new FlxTypeText(FlxG.width / 2, (FlxG.height / 2) + 100, FlxG.width, text, subtitleSize);
        subtitle.setFormat(Paths.getFontName(Paths.font('comic.ttf')), subtitleSize, FlxColor.WHITE, 'center', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        subtitle.antialiasing = true;
        subtitle.borderSize = 2;
        subtitle.screenCenter();

        var fucking = showTime; //cant access showTime for some reason

        subtitle.start(typeSpeed, false, false, [], function()
        {
            new FlxTimer().start(fucking, function(timer:FlxTimer)
            {
            FlxTween.tween(subtitle, {alpha: 0}, 0.5, {onComplete: function(tween:FlxTween)
            {
                onSubtitleComplete(subtitle);
            }});
            });
        });
		subtitle.x = (FlxG.width - subtitle.width) / 2;
		subtitle.y = ((FlxG.height - subtitle.height) / 2) - 200;
		fuck.add(subtitle);
    }
	public function onSubtitleComplete(subtitle:Subtitle)
	{
		fuck.remove(subtitle);
	}
}