class TweetController < ApplicationController
    
    def index
        @contents = Tweet.all
    end

    
    def new
        p request
    end
    
    def create
        t1=Tweet.new
        t1.contents=params[:content]
        t1.ip_address=request.ip
        t1.nickname=params[:nickname]
        #t1.time=request.date.to_s
        t1.save
        redirect_to "/tweet"
    end
    
    def show
        @content = Tweet.find(params[:id])
    end
    
    def edit
        @tweet=Tweet.find(params[:id])
    end
    
    def update
        tweet=Tweet.find(params[:id])
        tweet.contents = params[:content]
        tweet.nickname=params[:nickname]
        tweet.save
        redirect_to "/tweet"
    end
    
    def destroy
        id=Tweet.find(params[:id])
        id.destroy
        redirect_to "/tweet"
    end

    
end
