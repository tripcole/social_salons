class FollowRequestsController < ApplicationController
  def index
    matching_follow_requests = FollowRequest.all

    @list_of_follow_requests = matching_follow_requests.order({ :created_at => :desc })

    render({ :template => "follow_requests/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_follow_requests = FollowRequest.where({ :id => the_id })

    @the_follow_request = matching_follow_requests.at(0)

    render({ :template => "follow_requests/show.html.erb" })
  end

  def followers
    @the_followed = User.where({ :id => params.fetch("path_id")}).at(0)
    matching_followers = FollowRequest.all.where({ :recipient_id => @the_followed.id })
    @current_followers = matching_followers.where({ :status => "accepted" })
    @pending_followers = matching_followers.where({ :status => "pending" })

    render({ :template => "follow_requests/followers.html.erb" })
  end

  def following
    @the_follower = User.where({ :id => params.fetch("path_id")}).at(0)
    matching_following = FollowRequest.all.where({ :sender_id => @the_follower.id })
    @current_following = matching_following.where({ :status => "accepted" })
    @pending_following = matching_following.where({ :status => "pending" })
    
    render({ :template => "follow_requests/following.html.erb" })
  end

  def create
    the_follow_request = FollowRequest.new
    the_follow_request.sender_id = @current_user.id
    the_follow_request.recipient_id = params.fetch("query_recipient_id")
    recipient = User.where({ :id => the_follow_request.recipient_id }).at(0)

    # if !recipient.private
      # follow_request.status = "accepted"
    # else
    the_follow_request.status = "pending"
    # end

    if the_follow_request.valid?
      the_follow_request.save
      redirect_to("/follow_requests", { :notice => "Follow request created successfully." })
    else
      redirect_to("/follow_requests", { :notice => "Follow request failed to create successfully." })
    end
  end
  # def create
  #   the_follow_request = FollowRequest.new
  #   the_follow_request.sender_id = @current_user.id
  #   the_follow_request.recipient_id = params.fetch("query_recipient_id")
  #   the_follow_request.status = params.fetch("query_status")

  #   if the_follow_request.valid?
  #     the_follow_request.save
  #     redirect_to("/follow_requests", { :notice => "Follow request created successfully." })
  #   else
  #     redirect_to("/follow_requests", { :notice => "Follow request failed to create successfully." })
  #   end
  # end

  def update
    the_id = params.fetch("path_id")
    the_follow_request = FollowRequest.where({ :id => the_id }).at(0)

    the_follow_request.sender_id = params.fetch("query_sender_id")
    the_follow_request.recipient_id = params.fetch("query_recipient_id")
    the_follow_request.status = params.fetch("query_status")

    if the_follow_request.valid?
      the_follow_request.save
      redirect_to("/follow_requests/#{the_follow_request.id}", { :notice => "Request confirmed!"} )
    else
      redirect_to("/follow_requests/#{the_follow_request.id}", { :alert => "Follow request failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_follow_request = FollowRequest.where({ :id => the_id }).at(0)

    the_follow_request.destroy

    redirect_to("/follow_requests", { :notice => "Request denied."} )
  end
end
