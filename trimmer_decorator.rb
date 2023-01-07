require_relative 'base_decorator'

class TrimmerDecorator < BaseDecorator
  def correct_name
    corrected_name = @nameable.correct_name
    corrected_name = corrected_name.slice(0, 10) if corrected_name.length > 10
    corrected_name
  end
end
