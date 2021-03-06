class GamesController < ApplicationController
    def index
        games = Game.all
        render json: games     
    end

    def create
        # byebug
        if(params[:type] == "multi")
            if(params[:winner])
                game = Game.create(points: 50, gametype: params[:type], u2points: params[:loser])
            end

        else
            game = Game.create(points: params[:points], gametype: params[:type])

        end

        if(params[:user_id])
    
            user = User.find(params[:user_id])
        else
            user = User.first
        end
        
        user.games << game
        render json: user.games

    end



    def top
        math_games = Game.all.select{|e| e.gametype == "math"}.sort{|a,b| b.points.to_i <=> a.points.to_i}
        
        word_games = Game.all.select{|e| e.gametype == "word"}.sort{|a,b| b.points.to_i <=> a.points.to_i}

        multi_games = Game.all.select{|e| e.gametype == "multi"}

        math_array = []
        math_games[0...5].each{ |e| math_array.push({user:e.users.map{|e| e.user_name}, point: e.points}) }

        word_array = []
        word_games[0...5].each{ |e| word_array.push({user:e.users.map{|e| e.user_name}, point: e.points}) }
        
        users ={}
        multi_array=[]
        multi_games.each{ |e| multi_array.push({user: e.users.map{|e| e.user_name}})}
        test = multi_array[0][:user].join;
        multi_array.each do |e|
            e_user = e[:user].join
            if(users.keys.include?(e_user))
                count = users[ e_user ]
                count = count +1
                users[ e_user ] = count;
            else
                users[e_user] =1
            end
        end



        render json: {math: math_array, word:word_array, multi: users}

    end

 

end