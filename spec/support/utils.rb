def load_fixture(file_name)
    fixture = JSON.parse(File.read("spec/fixtures/payloads/#{file_name}.json"))
end