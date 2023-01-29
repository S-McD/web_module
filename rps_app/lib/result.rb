class Result
    def checker(selection, computer)
        if selection == computer
            return "You draw"
        elsif (selection == "Rock" && computer == "Scissors") || (selection == "Paper" && computer == "Rock") || (selection == "Scissors" && computer == "Paper")
            return "You win"
        end
        return "You lose"
    end
end