require_relative './base_decorator'

class TrimmerDecorator < BaseDecorator
  def correct_name
    name = @nameable.correct_name
    size = name.size
    return name.slice!(0..9) if size > 10

    name
  end
end
