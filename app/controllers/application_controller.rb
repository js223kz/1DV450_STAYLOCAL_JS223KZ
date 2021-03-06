class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  #protect_from_forgery with: :exception
  include LoginHelper
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  
  #override default thrown exception
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  
  #users of this api can only access api with valid apikey
  def authenticate_developer_key
      #authenticate_or_request_with_http_token do|token, options|
      unless Apikey.exists?(application_key: params[:key])
        render json: 
          {
            status: 401, 
            message: 'Felaktig API-nyckel. Skapa en nyckel här:  https://birdspotterdev.herokuapp.com'
          }, 
            status: 401
      end
  end
  
  #get token for end user to use when create, update, delete spot
  def token
      authenticate_with_http_basic do |email, password|
        birdspotter = Api::V1::Birdspotter.find_by(email: email)
        
        if birdspotter && birdspotter.authenticate(password)
          render json: { 
            status: 200, 
            message: "OK",
            token: birdspotter.user_token,
            id: birdspotter.id,
            username: birdspotter.user_name,
            email: birdspotter.email
          }, 
            status: 200
        else
          render json: 
          {
            status: 401, 
            message: 'Felaktiga inloggningsuppgifter.'
          }, 
            status: 401
        end
      end
  end
  
  #authenticate end user by token
  def authenticate_birdspotter_from_token
      authenticate_or_request_with_http_token do|usertoken, options|
        Api::V1::Birdspotter.exists?(user_token: usertoken)
      end
  end
  
  #logged in developer user
  def logged_in_user
    if logged_in?
      logged_in?
    else
      flash[:danger] = "Du måste logga in."
      redirect_to root_url
    end
  end
  
  private
  
  #Overrides default values in request_http_token_authentication built in method
  def request_http_token_authentication(realm = "Application")
    self.headers["WWW-Authenticate"] = %(Token realm="#{realm.gsub(/"/, "")}")
    render json:{
      status: 401,
      message: "HTTP Token: Åtkomst nekad på grund av felaktig användartoken."
    }, 
    status: 401
  end
  
  def destroy_session
    request.session_options[:skip] = true
  end
end
