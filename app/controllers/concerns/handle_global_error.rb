module HandleGlobalError
  def self.included _class
    _class.class_eval do
      rescue_from StandardError, with: :handle_global_error
    end
  end

  def handle_global_error error
    (ErrorMailer.global_error error.message).deliver_later
    raise error
  end
end
