json.extract! calendar_entry, :id, :villa_id, :date, :price, :available, :created_at, :updated_at
json.url calendar_entry_url(calendar_entry, format: :json)
