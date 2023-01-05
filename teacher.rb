require_relative 'person'

class Teacher < Person
  def initialize(specialization, age, name, _parent_permissions)
    super(age, name, parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
