import funkin.backend.utils.DiscordUtil;

function onReady() {
	DiscordUtil.changePresenceAdvanced({
		details: "lol",
		largeImageKey: "icon_logo"
	});
}