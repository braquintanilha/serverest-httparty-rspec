# frozen_string_literal: true

def load_fixture(file_name)
  JSON.parse(File.read("spec/fixtures/payloads/#{file_name}.json"))
end
