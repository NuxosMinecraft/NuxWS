class Donation < ActiveRecord::Base
  attr_accessible :amount, :anonymous, :user_id

  # Default order : 'created_at DESC' latest at top

  paginates_per 20

  validates_presence_of :amount

  def is_anonymous?
    return true if self.user_id.nil? or self.user_id.blank? or self.anonymous
    return false
  end

  def self.month_amount(month=:this)
    if month == :this
      Donation.by_month.map(&:amount).inject(0, :+)
    else
      Donation.by_month.map(&:amount).inject(0, :+)
    end
  end

  def self.month_percent(month=:this)
    amount = self.month_amount(month)
    if Settings.donations_goal_month.to_i == 0
      100
    else
      (amount * 100) / Settings.donations_goal_month.to_i
    end
  end
end
