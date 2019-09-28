class ApplicationController < ActionController::Base
  rescue_from ActionController::UnpermittedParameters, with: :error_render_method
  # Stop rails wrapping params
  wrap_parameters false

  # Customizing UnpermittedParams response to follow API specification.
  def error_render_method
    head :bad_request
  end
end
