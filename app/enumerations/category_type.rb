class CategoryType < EnumerateIt::Base
  associate_values(
      freefly:    ['freefly', 'Freefly'],
      mixed:      ['mixed', 'Mixed'],
      belly:      ['belly', 'Belly']
  )
end
