Rails.application.routes.draw do

  get("/", {:controller => "visits", :action => "index" })

  # Routes for the Follow request resource:

  # CREATE
  post("/insert_follow_request", { :controller => "follow_requests", :action => "create" })
          
  # READ
  get("/follow_requests", { :controller => "follow_requests", :action => "index" })
  
  get("/follow_requests/:path_id", { :controller => "follow_requests", :action => "show" })
  
  # UPDATE
  
  post("/modify_follow_request/:path_id", { :controller => "follow_requests", :action => "update" })
  
  # DELETE
  get("/delete_follow_request/:path_id", { :controller => "follow_requests", :action => "destroy" })

  #------------------------------

  # Routes for the Like resource:

  # CREATE
  post("/insert_like", { :controller => "likes", :action => "create" })
          
  # READ
  get("/likes", { :controller => "likes", :action => "index" })
  
  get("/likes/:path_id", { :controller => "likes", :action => "show" })
  
  # UPDATE
  
  post("/modify_like/:path_id", { :controller => "likes", :action => "update" })
  
  # DELETE
  get("/delete_like/:path_id", { :controller => "likes", :action => "destroy" })

  #------------------------------

  # Routes for the Visit resource:

  # CREATE
  post("/insert_visit", { :controller => "visits", :action => "create" })
          
  # READ
  get("/visits", { :controller => "visits", :action => "index" })
  
  get("/visits/:path_id", { :controller => "visits", :action => "show" })
  
  # UPDATE
  
  post("/modify_visit/:path_id", { :controller => "visits", :action => "update" })
  
  # DELETE
  get("/delete_visit/:path_id", { :controller => "visits", :action => "destroy" })

  #------------------------------

  # Routes for the Salon resource:

  # CREATE
  post("/insert_salon", { :controller => "salons", :action => "create" })
          
  # READ
  get("/salons", { :controller => "salons", :action => "index" })
  
  get("/salons/:path_id", { :controller => "salons", :action => "show" })
  
  # UPDATE
  
  post("/modify_salon/:path_id", { :controller => "salons", :action => "update" })
  
  # DELETE
  get("/delete_salon/:path_id", { :controller => "salons", :action => "destroy" })

  #------------------------------

  # Routes for the User account:
  get("/users", { :controller => "user_authentication", :action => "index" })

  # SIGN UP FORM
  get("/user_sign_up", { :controller => "user_authentication", :action => "sign_up_form" })        
  # CREATE RECORD
  post("/insert_user", { :controller => "user_authentication", :action => "create"  })
      
  # EDIT PROFILE FORM        
  get("/edit_user_profile", { :controller => "user_authentication", :action => "edit_profile_form" })       
  # UPDATE RECORD
  post("/modify_user", { :controller => "user_authentication", :action => "update" })
  
  # DELETE RECORD
  get("/cancel_user_account", { :controller => "user_authentication", :action => "destroy" })

  # ------------------------------

  # SIGN IN FORM
  get("/user_sign_in", { :controller => "user_authentication", :action => "sign_in_form" })
  # AUTHENTICATE AND STORE COOKIE
  post("/user_verify_credentials", { :controller => "user_authentication", :action => "create_cookie" })
  
  # SIGN OUT        
  get("/user_sign_out", { :controller => "user_authentication", :action => "destroy_cookies" })
             
  #------------------------------

end
