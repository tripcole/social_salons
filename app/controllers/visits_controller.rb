class VisitsController < ApplicationController
  def index
    matching_visits = Visit.all

    @list_of_visits = matching_visits.order({ :likes_count => :desc })

    render({ :template => "visits/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_visits = Visit.where({ :id => the_id })

    @the_visit = matching_visits.at(0)

    render({ :template => "visits/show.html.erb" })
  end

  def create
    the_visit = Visit.new
    the_visit.visit_date = params.fetch("query_visit_date")
    the_visit.user_id = @current_user.id
    the_visit.salon_id = params.fetch("query_salon_id")
    the_visit.rating = params.fetch("query_rating")
    the_visit.comment = params.fetch("query_comment")
    the_visit.image = params.fetch("query_image")
    the_visit.likes_count = 0

    if the_visit.valid?
      the_visit.save
      redirect_to("/visits", { :notice => "Visit created successfully." })
    else
      redirect_to("/visits", { :notice => "Visit failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_visit = Visit.where({ :id => the_id }).at(0)

    the_visit.visit_date = params.fetch("query_visit_date")
    the_visit.user_id = params.fetch("query_user_id")
    the_visit.salon_id = params.fetch("query_salon_id")
    the_visit.rating = params.fetch("query_rating")
    the_visit.comment = params.fetch("query_comment")
    the_visit.image = params.fetch("query_image")
    the_visit.likes_count = params.fetch("query_likes_count")

    if the_visit.valid?
      the_visit.save
      redirect_to("/visits/#{the_visit.id}", { :notice => "Visit updated successfully."} )
    else
      redirect_to("/visits/#{the_visit.id}", { :alert => "Visit failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_visit = Visit.where({ :id => the_id }).at(0)

    the_visit.destroy

    redirect_to("/visits", { :notice => "Visit deleted successfully."} )
  end
end
