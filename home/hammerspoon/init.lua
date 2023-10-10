--
-- global settings
--
hs.logger.defaultLogerLevel = "debug"

--
-- watch and reload config on changes
--
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
reloadWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")


--
-- spoon paths
--
package.path = package.path .. ";" ..  hs.configdir .. "/Spoons/Default/Spoons/Source/?.spoon/init.lua"
package.path = package.path .. ";" ..  hs.configdir .. "/Spoons/Custom/?.spoon/init.lua"


--
-- load spoons
--
-- hs.loadSpoon("Shade")
-- spoon.Shade:bindHotkeys({ 
--     toggleShade = { {"cmd","alt","ctrl"},"s" }
-- })
-- spoon.Shade.shadeTransparency = 0.99

--
-- load custom spoons
--

hs.loadSpoon("Slate")
hs.loadSpoon("Clippy")

-- hs.loadSpoon("WindowHalfsAndThirds")
-- spoon.WindowHalfsAndThirds:bindHotkeys(spoon.WindowHalfsAndThirds.defaultHotkeys)

hs.loadSpoon("ModalMgr")




-- hs.loadSpoon("MiroWindowsManager")

-- local hyper = {"alt", "cmd"}
-- spoon.MiroWindowsManager:bindHotkeys({
--     up = {hyper, "up"},
--   right = {hyper, "right"},
--   down = {hyper, "down"},
--   left = {hyper, "left"},
--   fullscreen = {hyper, "f"},
--   nextscreen = {hyper, "n"}
-- })


-- caffeine = hs.menubar.new()
-- function setCaffeineDisplay(state)
--     if state then
--         caffeine:setTitle("AWAKE")
--     else
--         caffeine:setTitle("SLEEPY")
--     end
-- end

-- function caffeineClicked()
--     setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
-- end

-- if caffeine then
--     caffeine:setClickCallback(caffeineClicked)
--     setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
-- end

