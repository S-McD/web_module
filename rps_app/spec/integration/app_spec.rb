require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }


    context 'GET /' do
        it 'should return the homepage with a form' do
        response = get('/')

        expect(response.status).to eq(200)
        expect(response.body).to include('<form action="/" method="POST">')
        expect(response.body).to include('<input type="text" name="selection" />')
        end
    end
    context 'POST /' do
        it 'should return result page' do
          response = post('/', selection: 'Rock')
    
          expect(response.status).to eq(200)
          expect(response.body).to include('You have selected Rock')
        end

        it "should redirect if selection incorrect" do
        response = post('/', selection: 'Water')

        expect(response.status).to eq(302)
        end
    end
end