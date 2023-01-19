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
    it "should validate album parameters" do
      response = post('/albums', title: "The Bends", release_year: nil, artist_id: "1")
      expect(response.status).to eq(400)
    end
    it 'should create a new album' do
      response = post('/albums', title: "Voyage", release_year: "2022", artist_id: 2)
      expect(response.status).to eq(200)
      # expect(response.body).to eq("")

      expected_response = get('/albums')
      expect(expected_response.body).to include("Voyage")
    end
    it 'returns a success page' do
      # We're now sending a POST request,
      # simulating the behaviour that the HTML form would have.
      response = post('/albums', title: 'ABBA Gold', release_year: '2008', artist_id: '2')
  
      expect(response.status).to eq(200)
      expect(response.body).to include('<p>Your album has been added!</p>')
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
    it "should validate artist parameters" do
      response = post('/artists', name: "Radiohead", genre: nil)
      expect(response.status).to eq(400)
    end
    it 'should create a new artist' do
      response = post('/artists', name: "Radiohead", genre: "Indie")
      expect(response.status).to eq(200)

      expected_response = get('/artists')
      expect(expected_response.body).to include("Radiohead")
    end
    it 'returns a success page' do
      response = post('/artists', name: "Radiohead", genre: "Indie")
  
      expect(response.status).to eq(200)
      expect(response.body).to include('<p>Your artist has been added!</p>')
    end
  end

  context "GET /albums/new" do
    it 'returns the form page' do
      response = get('/albums/new')
  
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Add a new album</h1>')
      expect(response.body).to include('<input type="text" name="title">','<input type="text" name="release_year">','<input type="text" name="artist_id">')
  
      # # Assert we have the correct form tag with the action and method.
      expect(response.body).to include('<form method="POST" action="/albums" >')
    end
  end
  context "GET /artists/new" do
    it 'returns the form page' do
      response = get('/artists/new')
  
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Add a new artist</h1>')
      expect(response.body).to include('<input type="text" name="name">','<input type="text" name="genre">')
  
      # # Assert we have the correct form tag with the action and method.
      expect(response.body).to include('<form method="POST" action="/artists">')
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
