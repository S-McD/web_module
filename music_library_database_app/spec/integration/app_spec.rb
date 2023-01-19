require "spec_helper"
require "rack/test"
require_relative '../../app'
require_relative "../artist_repository_spec"
require_relative "../album_repository_spec"

describe Application do
  before(:each) do 
    reset_artists_table
    reset_albums_table
  end
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "GET /albums" do
    it "returns a html list of albums" do
      response = get('/albums')
      expect(response.status).to eq(200)
      expect(response.body).to include('Title: Surfer Rosa','Release year: 1988')
      expect(response.body).to include('Title: Folklore','Release year: 2020')
    end
    # xit "returns a list of albums" do
    #   response = get('/albums')
    #   expected_response = "Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, Folklore, I Put a Spell on You, Baltimore, Here Comes the Sun, Fodder on My Wings, Ring Ring"
    #   expect(response.status).to eq(200)
    #   expect(response.body).to eq(expected_response)
    # end
  end
  context "POST /albums" do
    it 'should create a new album' do
      response = post('/albums', title: "Voyage", release_year: "2022", artist_id: 2)
      expect(response.status).to eq(200)
      expect(response.body).to eq("")

      expected_response = get('/albums')
      expect(expected_response.body).to include("Voyage")
    end
  end
  context "GET /artists" do
    it "returns a html list of artists" do
      response = get('/artists')
      expect(response.status).to eq(200)
      expect(response.body).to include('Name: Pixies','Genre: Rock')
      expect(response.body).to include('Name: ABBA','Genre: Pop')
    end
    # it "returns a list of artists" do
    #   response = get('/artists')
    #   expected_response = "Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos"
    #   expect(response.status).to eq(200)
    #   expect(response.body).to eq(expected_response)
    # end
  end
  context "POST /artists" do
    it 'should create a new artist' do
      response = post('/artists', name: "Wild nothing", genre: "Indie")
      expect(response.status).to eq(200)
      expect(response.body).to eq("")

      expected_response = get('/artists')
      expect(expected_response.body).to include("Wild nothing")
    end
  end
  context "GET /albums/:id" do
    it "should return album info by id number" do
      response = get('/albums/1')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Doolittle</h1>')
      expect(response.body).to include('Release year: 1989')
      expect(response.body).to include('Artist: Pixies')
    end
  end
  context "GET /artists/:id" do
    it "should return artist info by id number" do
      response = get('/artists/1')
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Pixies</h1>')
      expect(response.body).to include('Genre: Rock')
    end
  end
end
