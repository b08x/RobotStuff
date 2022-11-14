def parse_sync_address(address) # used to retrieve data which matched wild card in synced event
  v= get_event(address).to_s.split(",")[6]
  if v != nil
    return v[3..-2].split("/")
  else
    return ["error"]
  end
end
