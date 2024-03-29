class UserAuthenticationController < ApplicationController
  # Uncomment this if you want to force users to sign in before any other actions
  # skip_before_action(:force_user_sign_in, { :only => [:sign_up_form, :create, :sign_in_form, :create_cookie] })
  # Eventually remove
  def index
    matching_users = User.all
    @list_of_users = matching_users.order({ :created_at => :desc })
    render({ :template => "user_authentication/index.html.erb" })
  end

  # before_action(:load_user, { :only => [:show, :my_visits, :my_likes] })
  # before_action(:must_be_allowed, { :only => [:show, :my_visits, :my_likes] })
  # def load_user
  #   the_id = params.fetch("path_id")
  #   @user = User.where({ :id => the_id }).at(0)
  # end

  # def must_be_allowed
  #   if (@user != @current_user) && (@user.private && @user.followers.exclude?(@current_user))
  #     redirect_to("/", { :notice => "You're not authorized for that." })
  #   end
  # end

  def show
    matching_users = User.all
    @the_user = matching_users.where({ :id => params.fetch("path_id") }).at(0)
    matching_visits = Visit.all.where({ :user_id => @the_user.id })
    @user_visits = matching_visits.order({ :rating => :desc })
    
    matching_followers = FollowRequest.all.where({ :recipient_id => @the_user.id })
    @user_followers = matching_followers.where({ :status => "accepted" })
    @user_pending_followers = matching_followers.where({ :status => "pending" })

    matching_following = FollowRequest.all.where({ :sender_id => @the_user.id })
    @user_following = matching_following.where({ :status => "accepted" })
    @user_pending_following = matching_followers.where({ :status => "pending" })


    render({ :template => "user_authentication/show.html.erb" })
  end

  def my_visits 
    matching_visits = Visit.all.where({ :user_id => @current_user.id }) 
    @my_visits = matching_visits.order({ :rating => :desc })
    render({ :template => "visits/my_visits.html.erb" })
  end
  
  def my_likes
    matching_likes = Like.all.where({ :fan_id => @current_user.id }) 
    @my_likes = matching_likes.order({ :created_at => :desc })
    render({ :template => "likes/my_likes.html.erb"})
  end

  def sign_in_form
    render({ :template => "user_authentication/sign_in.html.erb" })
  end

  def create_cookie
    user = User.where({ :email => params.fetch("query_email") }).first
    
    the_supplied_password = params.fetch("query_password")
    
    if user != nil
      are_they_legit = user.authenticate(the_supplied_password)
    
      if are_they_legit == false
        redirect_to("/user_sign_in", { :alert => "Incorrect password." })
      else
        session[:user_id] = user.id
      
        redirect_to("/", { :notice => "Signed in successfully." })
      end
    else
      redirect_to("/user_sign_in", { :alert => "No user with that email address." })
    end
  end

  def destroy_cookies
    reset_session

    redirect_to("/", { :notice => "Signed out successfully." })
  end

  def sign_up_form
    render({ :template => "user_authentication/sign_up.html.erb" })
  end

  def create
    @user = User.new
    @user.email = params.fetch("query_email")
    @user.password = params.fetch("query_password")
    @user.password_confirmation = params.fetch("query_password_confirmation")
    @user.first_name = params.fetch("query_first_name")
    @user.last_name = params.fetch("query_last_name")
    @user.username = params.fetch("query_username")

    save_status = @user.save

    if save_status == true
      session[:user_id] = @user.id
   
      redirect_to("/", { :notice => "User account created successfully."})
    else
      redirect_to("/user_sign_up", { :alert => "User account failed to create successfully."})
    end
  end
    
  def edit_profile_form
    matching_followers = FollowRequest.all.where({ :recipient_id => @current_user.id })
    @my_followers = matching_followers.where({ :status => "accepted" })
    @my_pending_followers = matching_followers.where({ :status => "pending" })

    matching_following = FollowRequest.all.where({ :sender_id => @current_user.id })
    @my_following = matching_following.where({ :status => "accepted" })
    @my_pending_following = matching_followers.where({ :status => "pending" })
    
    render({ :template => "user_authentication/edit_profile.html.erb" })
  end

  def update
    @user = @current_user
    @user.email = params.fetch("query_email")
    @user.password = params.fetch("query_password")
    @user.password_confirmation = params.fetch("query_password_confirmation")
    @user.first_name = params.fetch("query_first_name")
    @user.last_name = params.fetch("query_last_name")
    @user.username = params.fetch("query_username")
    
    if @user.valid?
      @user.save

      redirect_to("/", { :notice => "User account updated successfully."})
    else
      render({ :template => "user_authentication/edit_profile_with_errors.html.erb" })
    end
  end

  def destroy
    @current_user.destroy
    reset_session
    
    redirect_to("/", { :notice => "User account cancelled" })
  end
  
  def newsfeed
    matching_following = FollowRequest.all.where({ :sender_id => @current_user.id })
    @my_following = matching_following.where({ :status => "accepted" })

    # matching_visits = Visit.all
    # @list_of_following_visits = matching_visits.at(0)

    render({ :template => "visits/newsfeed.html.erb" })
  end
 
end
