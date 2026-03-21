hs.window.animationDuration = 0

function getMargin(win)
  local screen = win:screen()
  local max = screen:fullFrame()

  local width = max.h * (16 / 9)

  if (max.w < width) then
    return 0
  end

  return (max.w - width) / 2
end

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function()
  local win = hs.window.focusedWindow()

  if (win == nil) then
    return
  end

  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  local margin = getMargin(win)
  local gutter = 30
  local width = (max.w - (2 * margin) - gutter) / 2

  f.x = max.x + margin
  f.y = max.y
  f.w = width
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", function()
  local win = hs.window.focusedWindow()

  if (win == nil) then
    return
  end

  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  local margin = getMargin(win)
  local gutter = 30
  local width = (max.w - (2 * margin) - gutter) / 2

  f.x = max.x + margin + width + gutter
  f.y = max.y
  f.w = width
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "C", function()
  local win = hs.window.focusedWindow()

  if (win == nil) then
    return
  end

  win:centerOnScreen()
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "M", function()
  local win = hs.window.focusedWindow()

  if (win == nil) then
    return
  end

  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  local margin = getMargin(win)
  local width = max.w - (2 * margin)

  f.x = max.x + margin
  f.y = max.y
  f.w = width
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.showHotkeys({"cmd", "alt", "ctrl"}, "H")
