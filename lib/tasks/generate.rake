namespace :generate do
  desc "generate certificate"
  task certificate: :environment do
    ::Generator::Certificate.run
  end
end
