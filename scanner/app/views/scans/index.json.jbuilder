json.array!(@scans) do |scan|
  json.extract! scan, :user_id, :scan_date, :ip_address, :status, :elapsed, :domain_name_ptr
  json.url scan_url(scan, format: :json)
end
