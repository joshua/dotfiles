local slate = {}
slate.__index = slate

local log = hs.logger.new("Slate")

local alt_cmd  = { "alt", "cmd" }
local ctrl_cmd = { "ctrl", "cmd" }

local rect  = {
   left_half        = {0.00,0.00,0.50,1.00},
   left_40          = {0.00,0.00,0.40,1.00},
   left_60          = {0.00,0.00,0.60,1.00},
   right_half       = {0.50,0.00,0.50,1.00},
   right_40         = {0.60,0.00,0.40,1.00},
   right_60         = {0.40,0.00,0.60,1.00},
   top_half         = {0.00,0.00,1.00,0.50},
   top_40           = {0.00,0.00,1.00,0.40},
   top_60           = {0.00,0.00,1.00,0.60},
   bottom_half      = {0.00,0.50,1.00,0.50},
   bottom_40        = {0.00,0.60,1.00,0.40},
   bottom_60        = {0.00,0.40,1.00,0.60},
   left_third       = {0.00,0.00,0.33,1.00},
   left_two_third   = {0.00,0.00,0.67,1.00},
   middle_third_h   = {0.33,0.00,0.34,1.00},
   right_third      = {0.67,0.00,0.33,1.00},
   right_two_third  = {0.33,0.00,0.67,1.00},
   top_third        = {0.00,0.00,1.00,0.33},
   top_two_third    = {0.00,0.00,1.00,0.67},
   middle_third_v   = {0.00,0.33,1.00,0.34},
   bottom_third     = {0.00,0.67,1.00,0.33},
   bottom_two_third = {0.00,0.33,1.00,0.67},
   top_left         = {0.00,0.00,0.50,0.50},
   top_right        = {0.50,0.00,0.50,0.50},
   bottom_left      = {0.00,0.50,0.50,0.50},
   bottom_right     = {0.50,0.50,0.50,0.50},
   max              = {0.00,0.00,1.00,1.00},
}

local actions = {
  left_chain = { rect.left_half, rect.left_third, rect.left_two_third },
}

slate.hotkeys = {
  powerMenu   = { { "shift", "ctrl", "alt", "cmd" }, "\\" },
  show        = { { "ctrl", "cmd" }, "s" },
  fullscreen  = { alt_cmd, "f" },
  center      = { alt_cmd, "c" },
  left_chain  = { alt_cmd, "Left"},
  right_chain = { alt_cmd, "Right"},
  -- bottom_right_corner = { alt_cmd, ""}
}

local function getCachedAction()
end

function slate:resizeAction(action)
  local win = hs.window.focusedWindow()
  if not win then return end
end

function slate:show()
  -- hs.grid.setGrid("3x3")
  -- hs.grid.show()
 
  -- local switcher = hs.chooser.new(function(c)
  --   if not c then return end
  --   hs.application.launchOrFocusByBundleID(c.id)
  -- end)

  -- local windows = hs.fnutils.map(hs.window.filter.new():getWindows(), function(win)
  --   if win ~= hs.window.focusedWindow() then
  --     return {
  --       text = win:title(),
  --       subText = win:application():title(),
  --       image = hs.image.imageFromAppBundle(win:application():bundleID()),
  --       id = win:application():bundleID()
  --     }
  --   end
  -- end)

  -- switcher:query(nil):placeholderText('Switch to...'):width(22):searchSubText(true):choices(windows):show()

  hs.caffeinate.systemSleep()
end

function slate:powerMenu()
  local actions = {
    lock        = hs.caffeinate.lockScreen,
    sleep       = hs.caffeinate.systemSleep,
    screensaver = hs.caffeinate.startScreensaver,
  }

  local switcher = hs.chooser.new(function(c)
    if not c then return end
    if actions[c.id] then actions[c.id]() end
  end)

  local choices = {
    {
      id = "lock",
      text = "Lock Screen",
      image = hs.image.imageFromName("NSLockLocked")
    },
    {
      id = "screensaver",
      text = "Start Screen Saver",
      image = hs.image.imageFromName("NSPlay") 
    },
    {
      id = "sleep",
      text = "Sleep",
      image = hs.image.imageFromName("NSSynchronize")
    },
  }

  switcher:query(nil)
    :placeholderText('Choose an action...')
    :rows(1)
    :width(12)
    :choices(choices)
    :fgColor(hs.drawing.color.x11.snow)
    -- :subTextColor(hs.drawing.color.x11.snow)
    :show()
end

function slate:fullscreen()
  local win = hs.window.focusedWindow()
  win:move(rect["max"])
end

function slate:center()
end

function slate:left_chain()
  local win = hs.window.focusedWindow()
  win:move(rect["left_half"])
end

function slate:right_chain()
  local win = hs.window.focusedWindow()
  win:move(rect["right_half"])
end

function slate:bindHotKeys()
  local hotkeyActions = {
    fullscreen = self.fullscreen,
    center = self.center,
    left_chain = self.left_chain,
    right_chain = self.right_chain,
    show = self.show,
    powerMenu = self.powerMenu
  }
  hs.spoons.bindHotkeysToSpec(hotkeyActions, self.hotkeys)
  return self
end

function slate:init()
  log.i("Initializing Slate Window Manager")
  print(hs.inspect(actions))
  self:bindHotKeys()
end

return slate
