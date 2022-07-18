class CertificatesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    Generator::Certificate.run(event_params)
    render json: {}, status: :created
  end

  def event_params
    params.require(:event).permit(:event_name, :event_date, :speaker, :preview, :participants => [])
  end
end
