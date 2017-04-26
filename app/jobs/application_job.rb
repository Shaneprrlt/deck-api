class ApplicationJob < ActiveJob::Base

  ## When ActiveRecord Models Are Unable to be Deserialized ##
  rescue_from ActiveJob::DeserializationError do |exception|
  end

end
