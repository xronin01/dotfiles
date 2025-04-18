-- Default Hilbish config
local hilbish = require 'hilbish'
local lunacolors = require 'lunacolors'
local bait = require 'bait'
local ansikit = require 'ansikit'

local unreadCount = 0
local running = false
local function doPrompt(fail)
	hilbish.prompt(lunacolors.format(
		'{blue}%u {cyan}%d ' .. (fail and '{red}' or '{green}') .. '∆ '
	))
end

local function doNotifyPrompt()
	if running or unreadCount == hilbish.messages.unreadCount() then return end

	local notifPrompt = string.format('• %s unread notification%s', hilbish.messages.unreadCount(), hilbish.messages.unreadCount() > 1 and 's' or '')
	unreadCount = hilbish.messages.unreadCount()
	hilbish.prompt(lunacolors.blue(notifPrompt), 'right')

	hilbish.timeout(function()
		hilbish.prompt('', 'right')
	end, 3000)
end

doPrompt()

bait.catch('command.preexec', function()
	running = true
end)

bait.catch('command.exit', function(code)
	running = false
	doPrompt(code ~= 0)
	doNotifyPrompt()
end)

bait.catch('hilbish.vimMode', function(mode)
	if mode ~= 'insert' then
		ansikit.cursorStyle(ansikit.blockCursor)
	else
		ansikit.cursorStyle(ansikit.lineCursor)
	end
end)

bait.catch('hilbish.notification', function(notif)
	doNotifyPrompt()
end)

--- Aliases
hilbish.alias("ls", "eza --icons --group-directories-first")
hilbish.alias("ll", "ls -l --git")
hilbish.alias("la", "ll -a")
hilbish.alias("tree", "ll --tree --level=2")
hilbish.alias("grep", "grep --color=auto")
hilbish.alias("cp", "cp --interactive")
hilbish.alias("mv", "mv --interactive")
hilbish.alias("rm", "rm --interactive")
hilbish.alias("..", "cd ..")
hilbish.alias("...", "cd ../..")
hilbish.alias("cmeta", "exiftool -all= -overwrite_original $@")
hilbish.alias("cat", "bat -pp")
hilbish.alias("bc", "bc-gh")
hilbish.alias("dc", "dc-gh")
hilbish.alias("vim", "nvim")
hilbish.alias("news", "newsboat")
hilbish.alias("cls", "clear")
