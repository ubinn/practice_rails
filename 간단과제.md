## 간단과제

- 처음부터 **TWITTER** 처음부터 만들어보기

- Bootstrap 적용하기

  - Gemfile `gem 'bootstrap','~> 4.1.1'` 후  `$ bundle install `
  - 

-  `rails _5.0.6_ new twitter_app`

  - Table (Model) : tweet

    `binn02:~/twitter_app $ rails g model tweet`

    

  - 작성한 사람의 ip주소 저장하기

  ```ruby
  class CreateTweets < ActiveRecord::Migration[5.0]
    def change
      create_table :tweets do |t|
        t.text "contents"
        t.string "ip_address"
        t.string "nickname"
        t.string "time"
        t.timestamps
      end
    end
  end
  ```

  

  `binn02:~/twitter_app $ rake db:migrate`

  

  - controller : tweetcontroller
    - action : *index, show, new, edit,update, destroy*

  `binn02:~/twitter_app $ rails g controller tweet`

  ```ruby
  # routes.rb
    get '/tweet' => 'tweet#index'
    get '/tweet/new' => 'tweet#new'
    post '/tweet/create' => 'tweet#create'
    get '/tweet/:id/destroy' => 'tweet#destroy'
    get '/tweet/:id' => 'tweet#show'
    get '/tweet/:id/edit' => 'tweet#edit'
    post '/tweet/:id/update' => 'tweet#update'
  ```

  ```ruby
  class TweetController < ApplicationController    
      def index
          @contents = Tweet.all
      end 
      def new
         # p request
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
  ```

  

  - view : *index, show, new, edit*

    *index.html.erb*

    ```ruby
    <div class="container">
        <div class="my-3 p-3 bg-white rounded box-shadow">
            <h6 class="border-bottom border-gray pb-2 mb-0">Recent updates</h6>
            <% @contents.reverse.each do |t| %>
            <div class="media text-muted pt-3">
              <img data-src="https://icon-icons.com/icons2/863/PNG/32/Twitter_icon-icons.com_67882.png&amp;size=1" alt="32x32" class="mr-2 rounded" style="width: 32px; height: 32px;" src="https://icon-icons.com/icons2/863/PNG/32/Twitter_icon-icons.com_67882.png" data-holder-rendered="true">
              <p class="media-body pb-3 mb-0 small lh-125 border-bottom border-gray">
                <strong class="d-block text-gray-dark"><%=t.nickname%><small> (<%=t.ip_address%>)</small></strong>
               
                <%=t.contents%>       
              
              <strong class="d-block text-right mt-3">
                <a href="/tweet/<%= t.id %>"> 보기 </a>
                <a href="/tweet/<%= t.id %>/edit"> 수정</a>
                <a data-confirm="이 글을 삭제하시겠습니까?" href="/tweet/<%= t.id %>/destroy">삭제</a></li>
              </strong>
              </p>
            </div>
            <% end %>
            <small class="d-block text-right mt-3">
              <a href="/tweet/new">새 글 등록하기</a>
            </small>
          </div>  
    </div>
    ```

    *new.html.erb*

    ```ruby
    <div class="container">
        <form action="/tweet/create" method="POST">
            <input type="hidden" name="authenticity_token" value="<%=form_authenticity_token%>">
            <div class="col-4">
            nickname
            <input class="form-control mr-sm-2" type="text" placeholder="닉네임" name="nickname" required>
            </div>
            <div class="col">
            content
            <input class="form-control" type="text" name="content" placeholder="내용을 입력하세요.">
            </div>
            <br/>
            <div class="form-row">
                <div class="col-5"><input type="hidden"></div>
                <input class="btn btn-primary" type="submit" value="등록">
            </div>
        </form>
    </div>
    ```

    *show.html.erb*

    ```ruby
    <div class="my-3 p-3 bg-white rounded box-shadow">
        <div class="cover-container d-flex w-100 h-100 p-3 mx-auto flex-column">
         <main role="main" class="inner cover">
            <span style="font:  bold; color: #4374D9;">
            <h2 class="cover-heading"><%= @content.nickname %> </h2>(<small><%=@content.ip_address%></small>)
            <br/>
            </span>
            <div class="text-center">
                <p class="lead">" <%= @content.contents %> "</p> <br/>
                <a href='/tweet'>List</a>
          </main>
          </div>
    </div>
    ```

    *edit.html.erb*

    ```ruby
    <form action="/tweet/<%=@tweet.id %>/update" method="POST">
        <input type="hidden" name="authenticity_token" value="<%=form_authenticity_token%>">
            <div class="col-4">
                nickname
                <input class="form-control mr-sm-2" type="text" value="<%=@tweet.nickname%>" name="nickname" required>
            </div>
            <div class="col">
                content
                <input class="form-control" type="text" name="content" value="<%=@tweet.contents%>">
            </div>
            <br/>
            <div class="form-row">
                <div class="col-5"><input type="hidden"></div>
                <input class="btn btn-primary" type="submit" value=" 수정하기 ">
            </div>
    </form>
    ```

  

  - index 에서는 `contents` 전체의 내용이 아닌 **앞의 10글자만 보여주기** 루비 코드 검색하쟈.