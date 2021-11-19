local Roact = require(script.Parent.Packages.Roact)

local StudioTheme = require(script.Parent.Packages.StudioTheme)

local e = Roact.createElement

return function()
  return StudioTheme.use(function(theme: StudioTheme, styles: table)
    return e("Frame", {
      BackgroundColor3 = theme:GetColor("MainBackground"),
      BorderSizePixel = 0,
      Size = UDim2.fromScale(1, 1),
    }, {
      e("Frame", {
        Size = UDim2.new(1, 0, 0, styles.spacing),
        BorderSizePixel = 0,
        BackgroundColor3 = styles.accent,
      }),

      e("TextLabel", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.new(1, styles.spacing * -2, 0, 0),
        Font = styles.font.mono,
        TextColor3 = theme:GetColor("MainText"),
        Text = "Hello, world!",
        TextSize = styles.fontSize * 3,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Center,
      }),
    })
  end)
end
