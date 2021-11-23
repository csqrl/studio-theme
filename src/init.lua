local Provider = require(script.Components.Provider)

return {
  Provider = Provider,
  use = Provider.use,

  -- Hooks --
  useTheme = require(script.Components.useTheme),

  -- Not neccessary to expose, but maybe useful --
  Context = require(script.Components.Context),
  MergeUtil = require(script.Util.MergeUtil),
}
