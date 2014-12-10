json.array!(@patients) do |patient|
  json.extract! patient, :id, :name, :age, :about
  json.url patient_url(patient, format: :json)
end
