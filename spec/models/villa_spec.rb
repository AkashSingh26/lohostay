# spec/models/villa_spec.rb
require 'rails_helper'

RSpec.describe Villa, type: :model do
  describe '.search_results' do
    let(:start_date) { Date.today }
    let(:end_date) { Date.today + 7 }
    let!(:villa1) { create(:villa, name: 'Villa One') }
    let!(:villa2) { create(:villa, name: 'Villa Two') }

    before do
      create(:calendar_entry, villa: villa1, date: start_date, price: 100, available: true)
      create(:calendar_entry, villa: villa1, date: end_date - 1, price: 100, available: true)
      create(:calendar_entry, villa: villa2, date: start_date, price: 200, available: false)
      create(:calendar_entry, villa: villa2, date: end_date - 1, price: 200, available: true)
    end

    it 'returns sorted villas by price' do
      sorted_villas = Villa.search_results(start_date, end_date, 'price')
      expect(sorted_villas.first[:name]).to eq('Villa Two')
      expect(sorted_villas.last[:name]).to eq('Villa One')
    end

    it 'returns sorted villas by availability' do
      sorted_villas = Villa.search_results(start_date, end_date, 'availability')
      expect(sorted_villas.first[:name]).to eq('Villa Two')  
      expect(sorted_villas.last[:name]).to eq('Villa One')  
    end
    
  end

  describe '#calculate_total_price' do
    let(:villa) { create(:villa) }
    let(:start_date) { Date.today }
    let(:end_date) { Date.today + 7 }

    before do
      create(:calendar_entry, villa: villa, date: start_date, price: 100)
      create(:calendar_entry, villa: villa, date: end_date - 1, price: 100)
    end

    it 'calculates the total price including GST' do
      expect(villa.calculate_total_price(start_date, end_date)).to eq(236)
    end
  end

  describe '#available_for_dates?' do
    let(:villa) { create(:villa) }
    let(:start_date) { Date.today }
    let(:end_date) { Date.today + 7 }

    before do
      (start_date...end_date).each do |date|
        create(:calendar_entry, villa: villa, date: date, available: true)
      end
    end

    it 'returns true if villa is available for all dates' do
      expect(villa.available_for_dates?(start_date, end_date)).to be_truthy
    end

    it 'returns false if villa is not available for any date' do
      create(:calendar_entry, villa: villa, date: end_date - 1, available: false)
      expect(villa.available_for_dates?(start_date, end_date)).to be_falsey
    end
  end
end
