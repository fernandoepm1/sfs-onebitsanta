# Preview all emails at http://localhost:3000/rails/mailers/gathering_mailer
class GatheringMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/gathering_mailer/raffle
  def raffle
    GatheringMailer.raffle
  end

end
