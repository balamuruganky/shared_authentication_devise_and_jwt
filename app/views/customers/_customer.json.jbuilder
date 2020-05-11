json.extract! customer, :id, :organisation_name, :address, :city, :state, :postcode, :country, :created_at, :updated_at
json.url customer_url(customer, format: :json)
