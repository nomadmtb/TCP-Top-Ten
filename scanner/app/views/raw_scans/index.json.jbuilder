json.array!(@raw_scans) do |raw_scan|
  json.extract! raw_scan, :scan_id, :raw_xml
  json.url raw_scan_url(raw_scan, format: :json)
end
