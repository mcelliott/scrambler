class TunnelHours < EnumerateIt::Base
  associate_values(
      beginner:    [1, "0 - 10 hours"],
      novice:      [2, "11 - 50 hours"],
      experienced: [3, "51 - 100 hours"],
      expert:      [4, "101 - 200 hours"],
      ninja:       [5, "201 + hours"]
  )
end
