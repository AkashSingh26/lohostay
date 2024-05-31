# == Schema Information
#
# Table name: calendar_entries
#
#  id         :string           not null, primary key
#  villa_id   :string           not null
#  date       :date
#  price      :integer
#  available  :boolean
#  created_at :datetime
#  updated_at :datetime


class CalendarEntry < ApplicationRecord
  belongs_to :villa

  validates :date, :price, presence: true
end
