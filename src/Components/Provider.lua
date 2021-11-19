local Studio = settings():GetService("Studio") :: Studio
local Roact = require(script.Parent.Parent.Roact)

local MergeUtil = require(script.Parent.Parent.Util.MergeUtil)
local Context = require(script.Parent.Context)

local e = Roact.createElement

local Component = Roact.Component:extend("ThemeProvider")

export type StylesDictionary = {
  [string]: any,
}

export type ThemeProviderProps = {
  styles: StylesDictionary,
  onUpdate: ((StudioTheme, StylesDictionary) -> StylesDictionary)?,
}

Component.defaultProps = {
  styles = {
    spacing = 8,
    borderRadius = 4,
    fontSize = 14,

    font = {
      light = Enum.Font.Gotham,
      default = Enum.Font.Gotham,
      bold = Enum.Font.GothamBold,
      mono = Enum.Font.Code,
    },
  },
} :: ThemeProviderProps

function Component:init()
  local styles = MergeUtil.Merge(
    Component.defaultProps.styles,
    self.props.styles
  )

  if type(self.props.onUpdate) == "function" then
    styles = self.props.onUpdate(Studio.Theme, styles)
  end

  self.styles = styles

  self._themeChanged = Studio.ThemeChanged:Connect(function()
    self:setState({})
  end)
end

function Component:didUpdate(prevProps: ThemeProviderProps)
  if prevProps.styles ~= self.props.styles then
    local styles = MergeUtil.Merge(
      Component.defaultProps.styles,
      self.props.styles
    )

    if type(self.props.onUpdate) == "function" then
      styles = self.props.onUpdate(Studio.Theme, styles)
    end

    self.styles = styles
    self:setState({})
  end
end

function Component:didMount()
  self:setState({})
end

function Component:willUnmount()
  self._themeChanged:Disconnect()
end

function Component:render()
  return e(Context.Theme.Provider, {
    value = {
      theme = Studio.Theme,
      styles = self.styles,
    },
  }, self.props[Roact.Children])
end

function Component.use(render: (StudioTheme, table) -> any)
  return Context.use(Context.Theme)(function(value)
    return render(value.theme, value.styles)
  end)
end

return Component
