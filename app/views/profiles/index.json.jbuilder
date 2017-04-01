json.array!(@profiles) do |profile|
  json.extract! profile, :id, :name_first, :name_last, :roster_epoch, :user_id
  json.url profile_url(profile, format: :json)
end
