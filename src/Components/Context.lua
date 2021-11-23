local Roact: Roact = require(script.Parent.Parent.Roact)

local ctx = Roact.createContext

local function use(context)
  return function(render)
    return Roact.createElement(context.Consumer, {
      render = function(value)
        return render(value)
      end,
    })
  end
end

return {
  Theme = ctx(nil),

  use = use,
}
