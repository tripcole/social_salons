class SalonsController < ApplicationController
  def index
    matching_salons = Salon.all

    @list_of_salons = matching_salons.order({ :created_at => :desc })

    render({ :template => "salons/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_salons = Salon.where({ :id => the_id })

    @the_salon = matching_salons.at(0)

    render({ :template => "salons/show.html.erb" })
  end

  def create
    the_salon = Salon.new
    the_salon.name = params.fetch("query_name")
    the_salon.description = params.fetch("query_description")
    the_salon.salon_type = params.fetch("query_salon_type")
    the_salon.street = params.fetch("query_street")
    the_salon.city = params.fetch("query_city")
    the_salon.state = params.fetch("query_state")
    the_salon.zip_code = params.fetch("query_zip_code")
    the_salon.address = params.fetch("query_address")

    if the_salon.valid?
      the_salon.save
      redirect_to("/salons", { :notice => "Salon created successfully." })
    else
      redirect_to("/salons", { :notice => "Salon failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_salon = Salon.where({ :id => the_id }).at(0)

    the_salon.name = params.fetch("query_name")
    the_salon.description = params.fetch("query_description")
    the_salon.salon_type = params.fetch("query_salon_type")
    the_salon.street = params.fetch("query_street")
    the_salon.city = params.fetch("query_city")
    the_salon.state = params.fetch("query_state")
    the_salon.zip_code = params.fetch("query_zip_code")
    the_salon.address = params.fetch("query_address")

    if the_salon.valid?
      the_salon.save
      redirect_to("/salons/#{the_salon.id}", { :notice => "Salon updated successfully."} )
    else
      redirect_to("/salons/#{the_salon.id}", { :alert => "Salon failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_salon = Salon.where({ :id => the_id }).at(0)

    the_salon.destroy

    redirect_to("/salons", { :notice => "Salon deleted successfully."} )
  end
end
