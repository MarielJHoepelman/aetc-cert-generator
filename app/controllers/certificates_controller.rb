class CertificatesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    permitted_params[:participants].each do |participant|
      ::Generator::Certificate.create_image(participant, permitted_params[:event_name], permitted_params[:event_date], permitted_params[:speaker])
    end
  end

  def permitted_params
    params.require(:event).permit(:event_name, :event_date, :speaker, :preview, :participants=>[])
  end
end

