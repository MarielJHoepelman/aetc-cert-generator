class CertificatesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    binding.pry
  end
end
