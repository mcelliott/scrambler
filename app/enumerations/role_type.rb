class RoleType < EnumerateIt::Base
  associate_values(
      user:    ['user', 'User'],
      manager: ['manager', 'Manager'],
      admin:   ['admin', 'Admin']
  )
end
