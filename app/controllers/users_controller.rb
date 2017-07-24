class UsersController < ApplicationController
  before_action :user_specific, only: [:show, :update]

  def index
  	 @users = User.all
  end

  def show
  end

 
  def update		
    byebug
    t = @user.oauth_token  
    @user.refresh! if @user.oauth_expires_at < Time.now
    #t.oauth_token
    byebug
 		smmtp = Net::SMTP.new('smtp.gmail.com', 587)
	  smmtp.enable_starttls_auto
	  byebug
	  smmtp.start('gmail.com', @user.email, @user.oauth_token, :xoauth2)
	  message = <<MESSAGE_END
From: Private Person <me@fromdomain.com>
To: #{params[:user][:email]}
MIME-Version: 1.0
Content-type: text/html
Subject: #{params[:user][:email]}
<%byebug%>
This is an e-mail message to be sent in HTML format

<b>This is HTML message.</b>
<h1>This is headline.</h1>
MESSAGE_END

	  byebug
	  smmtp.send_message message,@user.email,params[:user][:to]
	  byebug
	  smmtp.finish

	  redirect_to users_url
  end

  private

  def user_specific
  	@user = User.find(params[:id])
  end


end

