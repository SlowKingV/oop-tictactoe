# Player Class which stores the player's name, avatar, and score (for future features)
class Player
  @score = 0
  def initialize(name, avatar)
    @name = name
    @avatar = avatar
  end

  attr_reader :name, :avatar
end
