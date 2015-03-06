class TunnelHours < EnumerateIt::Base
  associate_values(
      beginner:    [0, "0 - 10 hours"],
      novice:      [1, "11 - 50 hours"],
      experienced: [2, "51 - 100 hours"],
      expert:      [3, "101 - 200 hours"],
      ninja:       [4, "201 + hours"]
  )
end
