class KarmaPoint < ActiveRecord::Base
  attr_accessible :user_id, :label, :value
  before_save :update_user_table
  belongs_to :user

  validates :user, :presence => true
  validates :value, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
  validates :label, :presence => true

  def update_user_table
    self.user.score += self.value
    self.user.save
  end
end
