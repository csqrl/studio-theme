local Roact = require(script.Packages.Roact)
local App = require(script.App)

local PluginHandle = Roact.mount(
  Roact.createElement(App, {
    plugin = plugin,
  }),
  nil,
  "ExamplePluginFacade"
)

plugin.Unloading:Connect(function()
  Roact.unmount(PluginHandle)
end)
