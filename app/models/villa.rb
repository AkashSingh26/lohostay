# == Schema Information
#
# Table name: villas
#
#  id         :string           not null, primary key
#  name       :string           not null
#  created_at :datetime
#  updated_at :datetime


class Villa < ApplicationRecord
  has_many :calendar_entries, dependent: :destroy

  def calculate_total_price(start_date, end_date)
    entries = calendar_entries.where(date: start_date...end_date)
    total_price = entries.sum(:price)
    total_price_with_gst = total_price * 1.18
    total_price_with_gst.round()
  end
end
