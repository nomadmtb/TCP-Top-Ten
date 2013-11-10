json.array!(@open_ports) do |open_port|
  json.extract! open_port, :scan_id, :port, :service
  json.url open_port_url(open_port, format: :json)
end
