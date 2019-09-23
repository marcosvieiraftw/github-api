require 'rspec'
require 'rails_helper'
require 'spec_helper'

RSpec.describe "Github Events", type: :request do
  path = File.join(Rails.root, 'spec', 'helpers')
  files = ['http00.txt', 'http01.txt', 'http02.txt', 'http03.txt', 'http04.txt']
  cnt = 1
  files.each do |file|
    it "Tests all events of Test - #{cnt}" do
      data = File.open(File.join(path, file)).read
      data.each_line do |row|
        req = JSON.parse(row)
        url = "http://localhost:8000"
        header = req["request"]["header"]
        body = req["request"]["body"]

        if req["request"]["method"] == "GET"
          url += req["request"]["url"]
          get url, body
          body = JSON.parse(response.body)
          expect(response.status).to eq(req["response"]["status_code"])
          expect(body).to eq(req["response"]["body"])

        elsif req["request"]["method"] == "POST"
          url += req["request"]["url"]
          post(url, body)
          body = JSON.parse(response.body)
          expect(response.status).to eq(req["response"]["status_code"])

        elsif req["request"]["method"] == "DELETE"
          url += req["request"]["url"]
          delete(url, body)
          expect(response.status).to eq(req["response"]["status_code"])

        elsif req["request"]["method"] == "PUT"
          url += req["request"]["url"]
          put(url, body)
          body = JSON.parse(response.body)
          expect(response.status).to eq(req["response"]["status_code"])
          expect(body).to eq(req["response"]["body"])

        end
      end
    end
    cnt += 1
  end
end
