json.array!(@base_rosters) do |base_roster|
  json.extract! base_roster, :id, :name, :version, :depot, :link, :duration, :type, :commencement_date, :number_of_lines
  json.url base_roster_url(base_roster, format: :json)
end
