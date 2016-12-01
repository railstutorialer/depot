class ErrorMailer < ApplicationMailer
  default from: 'railstutorial15@gmail.com', to: 'railstutorial15@gmail.com'

  def global_error error_message
    @error_message = error_message
    mail subject: 'An error occurred!'
  end

end
