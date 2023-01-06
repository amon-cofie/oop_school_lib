require_relative 'base_decorator'

class TrimmerDecorator < BaseDecorator
    def correct_name
        correctedName = @nameable.correct_name
        correctedName = correctedName.slice(0, 10) if correctedName.length > 10
        correctedName    
    end
end