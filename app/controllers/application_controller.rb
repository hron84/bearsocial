class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!
  before_filter :set_locale

  layout :xhr_layout

  def current_profile
    current_user && (current_user.profile || current_user.build_profile)
  end

  protected

  def add_flash
    flash[:error] = 'Test error message'
  end

  def set_locale

    # Allow to override locale
    # TODO Handle User#locale
    desired = params[:locale] if params[:locale]
    desired ||= if request.env['HTTP_ACCEPT_LANGUAGE']
                  # expected: hu,en;q=0.5
                  accepts = request.env['HTTP_ACCEPT_LANGUAGE'].split(';').first.split(',').map(&:to_sym)
                  # We hope it is in the order what user wants
                  accepts.find { |l| I18n.available_locales.include?(l) }
                end

    if desired && I18n.available_locales.include?(desired.to_sym)
      I18n.locale = desired
    else
      I18n.locale = I18n.default_locale
    end
  end

  def xhr_layout
    Rails.logger.info "Current controller is: #{self.class.name}"

    if request.xhr?
      false
    elsif self.class.name =~ /^Devise::/
      'login'
    else
      'application'
    end
  end

end
