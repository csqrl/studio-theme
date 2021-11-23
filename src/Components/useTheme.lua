local Context = require(script.Parent.Context)

return function(hooks): (StudioTheme, table)
  local context = hooks.useContext(Context.Theme)
  return context.theme, context.styles
end
