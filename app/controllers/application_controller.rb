# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionHelper

  private

  def require_login
    return if signed_in?

    flash[:danger] = 'Требуется логин'
    redirect_to session_login_url
  end
end
