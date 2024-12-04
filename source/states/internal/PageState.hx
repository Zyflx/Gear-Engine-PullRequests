package states.internal;

class PageState extends MainState
{
	public static var pageInstances:Map<String, FlxContainer> = [];

	public var currentPage:FlxContainer;

	public function new(page:String)
	{
		super();

		switchPage(page);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (currentPage?.exists && currentPage.active)
			currentPage.update(elapsed);
	}

	override public function draw()
	{
		super.draw();

		if (currentPage?.exists && currentPage.visible)
			currentPage.draw();
	}

	public function switchPage(page:String):Void
	{
		if (pageInstances.exists(page))
		{
			Transition.instance.transitionOut(() ->
			{
				currentPage = pageInstances.get(page);
				Transition.instance.transitionIn();
			});
		}
		else
		{
			FlxG.log.error('Page $page was not found.');
		}
	}
}