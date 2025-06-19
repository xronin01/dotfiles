--- libraries
local hilbish = require("hilbish")
local lunacolors = require("lunacolors")
local bait = require("bait")
local ansikit = require("ansikit")

hilbish.run("krabby name shellder")

--- Prompt
local function doPrompt(fail)
  -- stylua: ignore
  hilbish.prompt(lunacolors.format(
    "\n" .. "{blue} %d" .. "\n" .. (fail and "{red}" or "{green}") .. "❯ "
  ))
end
doPrompt()

bait.catch("command.exit", function(code)
  doPrompt(code ~= 0)
end)

--- vim mode
hilbish.inputMode("vim")

ansikit.cursorStyle(ansikit.lineCursor)

bait.catch("hilbish.vimMode", function(mode)
  if mode ~= "insert" then
    ansikit.cursorStyle(ansikit.blockCursor)
  else
    ansikit.cursorStyle(ansikit.lineCursor)
  end
end)

--- Options
hilbish.opts.motd = false
hilbish.opts.greeting = false
hilbish.opts.tips = false
hilbish.opts.fuzzy = true

--- Aliases
local aliases = {
  ls = "eza --icons --group-directories-first",
  ll = "ls -l --git",
  la = "ll -a",
  tree = "ls --tree --level=2",
  grep = "grep --color=auto",
  cp = "cp --interactive",
  mv = "mv --interactive",
  rm = "rm --interactive",
  [".."] = "cd ..",
  ["..."] = "cd ../..",
  cmeta = "exiftool -all= -overwrite_original $@",
  cat = "bat -pp",
  bc = "bc-gh",
  dc = "dc-gh",
  vim = "nvim",
  news = "newsboat",
  cls = "clear",
  npm = "pnpm",
}

for name, command in pairs(aliases) do
  hilbish.alias(name, command)
end
