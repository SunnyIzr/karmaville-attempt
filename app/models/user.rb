class User < ActiveRecord::Base
  has_many :karma_points

  attr_accessible :first_name, :last_name, :email, :username, :score

  validates :first_name, :presence => true
  validates :last_name, :presence => true

  validates :username,
            :presence => true,
            :length => {:minimum => 2, :maximum => 32},
            :format => {:with => /^\w+$/},
            :uniqueness => {:case_sensitive => false}

  validates :email,
            :presence => true,
            :format => {:with => /^[\w+\-.]+@[a-z\d\-.]+\.[a-z]+$/i},
            :uniqueness => {:case_sensitive => false}

  def self.by_karma
    # joins(:karma_points).group('users.id').order('SUM(karma_points.value) DESC')
    order("score DESC")
  end

  def total_karma
    self.score
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def karma_score
    self.karma_points.collect { |pt| pt.value}.inject(:+)
  end

  def self.seed_score_data
    all.each do |user|
      user.score = user.karma_score
      user.save(:validate => false)
    end
  end
end
