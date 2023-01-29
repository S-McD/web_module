require "result"

RSpec.describe Result do
    it "checks the result and returns message" do
        game = Result.new
        response = game.checker('Rock', 'Paper')
        expect(response).to eq "You lose"
    end
    it "checks another result and returns a different message" do
        game = Result.new
        response = game.checker('Rock', 'Rock')
        expect(response).to eq "You draw"
    end
    it "checks another result and returns a different message" do
        game = Result.new
        response = game.checker('Paper', 'Rock')
        expect(response).to eq "You win"
    end
end