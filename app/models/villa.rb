# == Schema Information
#
# Table name: villas
#
#  id         :string           not null, primary key
#  name       :string           not null
#  created_at :datetime
#  updated_at :datetime


class Villa < ApplicationRecord
  has_many_attached :images

  has_many :calendar_entries, dependent: :destroy

  validates :name, presence: true

  def self.search_results(start_date, end_date, sort_by)
    villas = Villa.includes(:calendar_entries).all

    villas = villas.map { |villa| build_villa_hash(villa, start_date, end_date) }

    sort_villas(villas, sort_by)
  end

  def calculate_total_price(start_date, end_date)
    return 0 if start_date.nil? || end_date.nil?
    entries = avg_dates(start_date, end_date)
    total_price = entries.sum(:price)
    total_price_with_gst = total_price * 1.18
    total_price_with_gst.round()
  end

  def average_price_for_dates(start_date, end_date)
    entries = avg_dates(start_date, end_date)
    entries&.average(:price)&.round
  end

  def avg_dates(start_date, end_date)
    start_date.eql?(end_date) ? calendar_entries.where(date: start_date) : calendar_entries.where(date: start_date...end_date)
  end

  def available_for_dates?(start_date, end_date)
    check_date_range = (start_date...end_date)
    entries = calendar_entries.where(date: check_date_range)

    if entries.count == (end_date - start_date).to_i
      entries[0...-1].all?(&:available) || (entries[0...-1].all?(&:available) && !entries.last.available)
    else
      false
    end
  end

  private

  def self.build_villa_hash(villa, start_date, end_date)
    {
      id: villa.id,
      name: villa.name,
      average_price_per_night: villa.average_price_for_dates(start_date, end_date),
      availability: villa.available_for_dates?(start_date, end_date),
      start_date: start_date,
      end_date: end_date,
      images: villa.images
    }
  end

  def self.sort_villas(villas, sort_by)
    villas.sort_by! do |villa|
      case sort_by
      when 'price'
        -villa[:average_price_per_night]
      when 'availability'
        [villa[:availability] ? 0 : 1, -villa[:average_price_per_night]]
      else
        -villa[:average_price_per_night]
      end
    end
  end
end
