if not script.Parent.DevPackages:FindFirstChild("StudioPlugin") then
  error(
    "`csqrl/studio-plugin@^1.0.0` package not found. Add it to your `DevPackages/` dir to continue."
  )
end

local Roact = require(script.Parent.Packages.Roact)

local StudioPlugin = require(script.Parent.DevPackages.StudioPlugin)
local StudioTheme = require(script.Parent.Packages.StudioTheme)

local Contents = require(script.Parent.Contents)

local e = Roact.createElement

local App = Roact.Component:extend("App")

function App:init()
  self:setState({
    widget = false,
  })
end

function App:render()
  return e(StudioPlugin.Plugin, {
    plugin = self.props.plugin,
  }, {
    toolbar = e(StudioPlugin.Toolbar, {
      name = "StudioTheme",
    }, {
      button = e(StudioPlugin.ToolbarButton, {
        id = "main-button",
        label = "Test",
        active = self.state.widget,
        onActivated = function()
          self:setState({ widget = not self.state.widget })
        end,
      }),
    }),

    widget = e(StudioPlugin.Widget, {
      id = "test-widget",
      title = "Test Widget",
      enabled = self.state.widget,
      onInit = function(enabled)
        self:setState({ widget = enabled })
      end,
      onToggle = function(enabled)
        self:setState({ widget = enabled })
      end,
    }, {
      themeProvider = e(StudioTheme.Provider, {
        onUpdate = function(theme: StudioTheme, styles)
          styles.accent = theme:GetColor("LinkText")

          return styles
        end,
      }, {
        contents = e(Contents),
      }),
    }),
  })
end

return App
