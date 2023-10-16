require_relative '../item'

class Game < Item
  attr_accessor :multiplayer, :last_played_at

  def initialize(multiplayer, last_played_at)
    super()
    @multiplayer = multiplayer
    @last_played_at = last_played_at
  end

  private

  def can_be_archived?()
    years = Time.now.year - @last_played_at.year
    super && (years > 2)
  end
end
