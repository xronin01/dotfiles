pcall(require, "luarocks.loader")

--- libraries
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local ruled = require("ruled")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

require("awful.autofocus")

--- Error handling
naughty.connect_signal("request::display_error", function(message, startup)
  naughty.notification({
    urgency = "critical",
    title = "Oops, an error happened" .. (startup and " during startup!" or "!"),
    message = message,
  })
end)

--- Theme
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")

--- Wallpaper
awful.spawn.with_shell("nitrogen --restore")
-- beautiful.wallpaper = ""
-- -- local geometry = s.geometry
-- -- if geometry.width > geometry.height then
-- --   -- landscape wallpaper
-- --   beautiful.wallpaper = ""
-- -- else
-- --   -- portrait wallpaper
-- --   beautiful.wallpaper = ""
-- -- end
--
-- screen.connect_signal("request::wallpaper", function(s)
--   -- gears.wallpaper.maximized(beautiful.wallpaper)
--   awful.wallpaper({
--     screen = s,
--     widget = {
--       {
--         image = beautiful.wallpaper,
--         upscale = true,
--         downscale = true,
--         widget = wibox.widget.imagebox,
--       },
--       valign = "center",
--       halign = "center",
--       tiled = false,
--       widget = wibox.container.tile,
--     },
--   })
-- end)

--- Default programs
terminal = os.getenv("TERMCMD") or "xterm"
editor = os.getenv("EDITOR") or "vi"
editor_cmd = terminal .. " -e " .. editor
applauncher = function()
  menubar.show()
  -- awful.spawn(terminal .. " --class=launcher -e ~/sway-launcher-desktop/sway-launcher-desktop.sh", {
  --   floating = true,
  --   sticky = true,
  --   width = 480,
  --   height = 480,
  --   placement = awful.placement.centered,
  --   -- titlebars_enabled = false,
  -- })
end

--- Menu
myawesomemenu = {
  {
    "hotkeys",
    function()
      hotkeys_popup.show_help(nil, awful.screen.focused())
    end,
  },
  { "manual", terminal .. " -e man awesome" },
  { "config", editor_cmd .. " " .. awesome.conffile },
  { "restart", awesome.restart },
  {
    "quit",
    function()
      awesome.quit()
    end,
  },
}
mymainmenu = awful.menu({
  items = {
    { "awesome", myawesomemenu, beautiful.awesome_icon },
    { "terminal", terminal },
    { "launcher", applauncher },
  },
})

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu })

--- Layouts
tag.connect_signal("request::default_layouts", function()
  awful.layout.append_default_layouts({
    awful.layout.suit.tile,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    awful.layout.suit.floating,
  })
end)

--- Statusbar
screen.connect_signal("request::desktop_decoration", function(s)
  awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

  s.mytaglist = awful.widget.taglist({
    screen = s,
    filter = awful.widget.taglist.filter.all,
    buttons = {
      awful.button({}, 1, function(t)
        t:view_only()
      end),
      awful.button({ modkey }, 1, function(t)
        if client.focus then
          client.focus:move_to_tag(t)
        end
      end),
      awful.button({}, 3, awful.tag.viewtoggle),
      awful.button({ modkey }, 3, function(t)
        if client.focus then
          client.focus:toggle_tag(t)
        end
      end),
    },
  })

  s.mypromptbox = awful.widget.prompt()

  s.mytasklist = awful.widget.tasklist({
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = {
      awful.button({}, 1, function(c)
        c:activate({ context = "tasklist", action = "toggle_minimization" })
      end),
      awful.button({}, 3, function()
        awful.menu.client_list({ theme = { width = 250 } })
      end),
    },
  })

  s.mytextclock = wibox.widget.textclock(" %d-%m-%y %H:%M ")

  s.mysystray = wibox.widget.systray()

  s.mylayoutbox = awful.widget.layoutbox({
    screen = s,
    buttons = {
      awful.button({}, 1, function()
        awful.layout.inc(1)
      end),
      awful.button({}, 3, function()
        awful.layout.inc(-1)
      end),
    },
  })

  s.mywibox = awful.wibar({
    position = "top",
    screen = s,
    widget = {
      layout = wibox.layout.align.horizontal,
      {
        layout = wibox.layout.fixed.horizontal,
        mylauncher,
        s.mytaglist,
        s.mypromptbox,
      },
      s.mytasklist,
      {
        layout = wibox.layout.fixed.horizontal,
        s.mytextclock,
        s.mysystray,
        s.mylayoutbox,
      },
    },
  })
end)

--- Keymaps
modkey = "Mod4"

awful.mouse.append_global_mousebindings({
  awful.button({}, 3, function()
    mymainmenu:toggle()
  end),
  awful.button({}, 1, function()
    mymainmenu:hide()
  end),
})

awful.keyboard.append_global_keybindings({
  awful.key({ modkey, "Shift" }, "/", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
  awful.key({ modkey }, "w", function()
    mymainmenu:show()
  end, { description = "show main menu", group = "awesome" }),
  awful.key({ modkey, "Shift" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
  awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),
  awful.key({ modkey }, "x", function()
    awful.prompt.run({
      prompt = "Run Lua code: ",
      textbox = awful.screen.focused().mypromptbox.widget,
      exe_callback = awful.util.eval,
      history_path = awful.util.get_cache_dir() .. "/history_eval",
    })
  end, { description = "lua execute prompt", group = "awesome" }),

  awful.key({ modkey }, "Return", function()
    awful.spawn(terminal)
  end, { description = "terminal", group = "launcher" }),
  awful.key({ modkey }, "r", function()
    awful.screen.focused().mypromptbox:run()
  end, { description = "run prompt", group = "launcher" }),
  awful.key({ modkey }, "d", function()
    applauncher()
  end, { description = "app launcher", group = "launcher" }),

  awful.key({ modkey, "Shift" }, "n", function()
    local c = awful.client.restore()
    if c then
      c:activate({ raise = true, context = "key.unminimize" })
    end
  end, { description = "restore minimized", group = "client" }),
  awful.key({ modkey }, "Tab", function()
    awful.client.focus.byidx(1)
  end, { description = "focus next by index", group = "client" }),

  awful.key({ modkey }, "h", function()
    awful.client.focus.bydirection("left")
  end, { description = "focus left", group = "client" }),
  awful.key({ modkey }, "j", function()
    awful.client.focus.bydirection("down")
  end, { description = "focus down", group = "client" }),
  awful.key({ modkey }, "k", function()
    awful.client.focus.bydirection("up")
  end, { description = "focus up", group = "client" }),
  awful.key({ modkey }, "l", function()
    awful.client.focus.bydirection("right")
  end, { description = "focus right", group = "client" }),

  awful.key({ modkey }, "Left", function()
    awful.client.focus.bydirection("left")
  end, { description = "focus left", group = "client" }),
  awful.key({ modkey }, "Down", function()
    awful.client.focus.bydirection("down")
  end, { description = "focus down", group = "client" }),
  awful.key({ modkey }, "Up", function()
    awful.client.focus.bydirection("up")
  end, { description = "focus up", group = "client" }),
  awful.key({ modkey }, "Right", function()
    awful.client.focus.bydirection("right")
  end, { description = "focus right", group = "client" }),

  awful.key({ modkey, "Shift" }, "h", function()
    awful.client.swap.bydirection("left")
  end, { description = "swap left", group = "client" }),
  awful.key({ modkey, "Shift" }, "j", function()
    awful.client.swap.bydirection("down")
  end, { description = "swap down", group = "client" }),
  awful.key({ modkey, "Shift" }, "k", function()
    awful.client.swap.bydirection("up")
  end, { description = "swap up", group = "client" }),
  awful.key({ modkey, "Shift" }, "l", function()
    awful.client.swap.bydirection("right")
  end, { description = "swap right", group = "client" }),

  awful.key({ modkey, "Shift" }, "Left", function()
    awful.client.swap.bydirection("left")
  end, { description = "swap left", group = "client" }),
  awful.key({ modkey, "Shift" }, "Down", function()
    awful.client.swap.bydirection("down")
  end, { description = "swap down", group = "client" }),
  awful.key({ modkey, "Shift" }, "Up", function()
    awful.client.swap.bydirection("up")
  end, { description = "swap up", group = "client" }),
  awful.key({ modkey, "Shift" }, "Right", function()
    awful.client.swap.bydirection("right")
  end, { description = "swap right", group = "client" }),

  awful.key({ modkey, "Mod1" }, "h", function()
    awful.tag.incmwfact(-0.05)
  end, { description = "decrease master width factor", group = "layout" }),
  awful.key({ modkey, "Mod1" }, "j", function()
    awful.client.incwfact(0.05)
  end, { description = "increase client height", group = "layout" }),
  awful.key({ modkey, "Mod1" }, "k", function()
    awful.client.incwfact(-0.05)
  end, { description = "decrease client height", group = "layout" }),
  awful.key({ modkey, "Mod1" }, "l", function()
    awful.tag.incmwfact(0.05)
  end, { description = "increase master width factor", group = "layout" }),

  awful.key({ modkey, "Mod1" }, "Left", function()
    awful.tag.incmwfact(-0.05)
  end, { description = "decrease master width factor", group = "layout" }),
  awful.key({ modkey, "Mod1" }, "Down", function()
    awful.client.incwfact(0.05)
  end, { description = "increase client height", group = "layout" }),
  awful.key({ modkey, "Mod1" }, "Up", function()
    awful.client.incwfact(-0.05)
  end, { description = "decrease client height", group = "layout" }),
  awful.key({ modkey, "Mod1" }, "Right", function()
    awful.tag.incmwfact(0.05)
  end, { description = "increase master width factor", group = "layout" }),

  awful.key({ modkey }, "space", function()
    awful.layout.inc(1)
  end, { description = "layout next by index", group = "layout" }),

  awful.key({
    modifiers = { modkey },
    keygroup = "numrow",
    description = "only view tag",
    group = "tag",
    on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        tag:view_only()
      end
    end,
  }),
  awful.key({
    modifiers = { modkey, "Control" },
    keygroup = "numrow",
    description = "toggle tag",
    group = "tag",
    on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end,
  }),
  awful.key({
    modifiers = { modkey, "Shift" },
    keygroup = "numrow",
    description = "move focused client to tag",
    group = "tag",
    on_press = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end,
  }),
  awful.key({
    modifiers = { modkey, "Control", "Shift" },
    keygroup = "numrow",
    description = "toggle focused client on tag",
    group = "tag",
    on_press = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:toggle_tag(tag)
        end
      end
    end,
  }),
  awful.key({
    modifiers = { modkey },
    keygroup = "numpad",
    description = "select layout directly",
    group = "layout",
    on_press = function(index)
      local t = awful.screen.focused().selected_tag
      if t then
        t.layout = t.layouts[index] or t.layout
      end
    end,
  }),
})

client.connect_signal("request::default_mousebindings", function()
  awful.mouse.append_client_mousebindings({
    awful.button({}, 1, function(c)
      c:activate({ context = "mouse_click" })
    end),
    awful.button({ modkey }, 1, function(c)
      c:activate({ context = "mouse_click", action = "mouse_move" })
    end),
    awful.button({ modkey }, 3, function(c)
      c:activate({ context = "mouse_click", action = "mouse_resize" })
    end),
  })
end)

client.connect_signal("request::default_keybindings", function()
  awful.keyboard.append_client_keybindings({
    awful.key({ modkey }, "q", function(c)
      c:kill()
    end, { description = "close", group = "client" }),
    awful.key({ modkey }, "m", function(c)
      c.maximized = not c.maximized
      c:raise()
    end, { description = "(un)maximize", group = "client" }),
    awful.key({ modkey }, "n", function(c)
      c.minimized = true
    end, { description = "minimize", group = "client" }),
    awful.key(
      { modkey, "Shift" },
      "space",
      awful.client.floating.toggle,
      { description = "toggle floating", group = "client" }
    ),
    awful.key({ modkey }, "t", function(c)
      c.ontop = not c.ontop
    end, { description = "toggle keep on top", group = "client" }),
    awful.key({ modkey }, "s", function(c)
      c.sticky = not c.sticky
    end, { description = "toggle sticky", group = "client" }),
    awful.key({ modkey }, "f", function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end, { description = "toggle fullscreen", group = "client" }),
    awful.key({ modkey }, "o", function(c)
      c:move_to_screen()
    end, { description = "move to screen", group = "client" }),
  })
end)

--- Rules
ruled.client.connect_signal("request::rules", function()
  ruled.client.append_rule({
    id = "global",
    rule = {},
    properties = {
      border_width = beautiful.client_border_width,
      focus = awful.client.focus.filter,
      raise = true,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
    },
  })

  ruled.client.append_rule({
    id = "floating",
    rule_any = {
      instance = { "copyq", "pinentry" },
      class = {
        "Arandr",
        "Blueman-manager",
        "Gpick",
        "Kruler",
        "Nsxiv",
        "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size
        "Wpa_gui",
        "veromix",
        "xtightvncviewer",
      },
      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      name = {
        "Event Tester", -- xev.
      },
      role = {
        "AlarmWindow", -- Thunderbird's calendar.
        "ConfigManager", -- Thunderbird's about:config.
        "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
      },
    },
    properties = { floating = true },
  })

  ruled.client.append_rule({
    id = "titlebars",
    rule_any = { type = { "normal", "dialog" } },
    properties = { titlebars_enabled = true },
  })
end)

--- Titlebar
client.connect_signal("request::titlebars", function(c)
  local buttons = {
    awful.button({}, 1, function()
      c:activate({ context = "titlebar", action = "mouse_move" })
    end),
    awful.button({}, 3, function()
      c:activate({ context = "titlebar", action = "mouse_resize" })
    end),
  }

  awful.titlebar(c).widget = {
    {
      awful.titlebar.widget.floatingbutton(c),
      awful.titlebar.widget.ontopbutton(c),
      awful.titlebar.widget.stickybutton(c),
      layout = wibox.layout.fixed.horizontal,
    },
    {
      {
        halign = "center",
        widget = awful.titlebar.widget.titlewidget(c),
      },
      buttons = buttons,
      layout = wibox.layout.flex.horizontal,
    },
    {
      awful.titlebar.widget.minimizebutton(c),
      awful.titlebar.widget.maximizedbutton(c),
      awful.titlebar.widget.closebutton(c),
      layout = wibox.layout.fixed.horizontal(),
    },
    layout = wibox.layout.align.horizontal,
  }
end)

--- Notifications
ruled.notification.connect_signal("request::rules", function()
  ruled.notification.append_rule({
    rule = {},
    properties = {
      screen = awful.screen.preferred,
      implicit_timeout = 5,
    },
  })

  ruled.notification.append_rule({
    rule = { urgency = "critical" },
    properties = { bg = beautiful.bg_urgent, fg = beautiful.fg_normal },
  })
end)

naughty.connect_signal("request::display", function(n)
  naughty.layout.box({ notification = n })
end)

--- Focus follows the mouse
client.connect_signal("mouse::enter", function(c)
  c:activate({ context = "mouse_enter", raise = false })
end)
