class CategoryType < EnumerateIt::Base
  associate_values(
      freefly:    ['freefly', 'Freefly'],
      belly:      ['belly', 'Belly']
  )
end
