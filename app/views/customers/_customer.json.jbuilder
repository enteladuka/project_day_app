json.extract! customer, :id, :company, :address, :city, :state, :zip, :created_at, :updated_at
json.url customer_url(customer, format: :json)
