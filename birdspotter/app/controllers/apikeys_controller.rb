class ApikeysController < ApplicationController
  before_action :logged_in?, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @apikey = current_user.apikeys.build(apikey_params)
    if @apikey.save
      flash[:success] = "Du har registrerat en ny applikation"
      
      #this redirects user to page that
      #issued create
      redirect_to request.referrer || root_url
    else
      flash.now[:danger] = 'Vi kunde i spara din applikation. Försök igen.'
      redirect_to current_user
    end
  end
  
  def destroy
      @apikey.destroy
      flash[:success] = "Applikationen är raderad."
      
      #this redirects user to page that
      #issued delete
      redirect_to request.referrer || root_url
  end
  
  private

    def apikey_params
      params.require(:apikey).permit(:application_name)
    end
    
    def correct_user
      @apikey = current_user.apikeys.find_by(id: params[:id])
      redirect_to root_url if @apikey.nil?
    end
    
end