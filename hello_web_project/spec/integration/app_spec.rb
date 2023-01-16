require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "GET to /hello" do
    it "returns 200 OK with the right content" do
      # Send a GET request to /hello
      # and returns a response object we can test.
      response = get("/hello", name: "Leo")

      # Assert the response status code and body.
      expect(response.status).to eq(200)
      expect(response.body).to eq("Hello Leo")
    end
  end

  context "POST to /submit" do
    it "returns 200 OK with the right content" do
      # Send a POST request to /submit
      # with some body parameters
      # and returns a response object we can test.
      response = post("/submit", name: "Leo", message: "Hello world")

      # Assert the response status code and body.
      expect(response.status).to eq(200)
      expect(response.body).to eq("Thanks Leo, you sent this message: Hello world")
    end
  end
  context "GET /names" do
    it 'returns 200 OK with the right content' do
      response = get('/names', message: "Julia, Mary, Karim")

      expect(response.status).to eq(200)
      expect(response.body).to eq("Julia, Mary, Karim")
    end
  end
  context "POST /sort-names" do
    it 'returns 200 OK with the right content' do
      response = post('/sort-names', message: "Joe,Alice,Zoe,Julia,Kieran")

      expect(response.status).to eq(200)
      expect(response.body).to eq("Alice,Joe,Julia,Kieran,Zoe")
    end
  end
end