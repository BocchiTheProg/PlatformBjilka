class ApplicationController < ActionController::Base
  # #before_action :set_locale
  # around_action :set_locale
  # # def set_locale
  # #     #I18n.locale = params[:lang] || locale_from_header  #|| I18n.default_locale
  # #     I18n.locale = params[:lang] || I18n.default_locale
  # # end

  # def set_locale
  #     # if session[:lang] != :uk || session[:lang] != :en
  #     #     session[:lang] = nil
  #     # end
  #     # I18n.locale = session[:lang] || I18n.default_locale
  #     I18n.locale = session[:lang] || I18n.default_locale
  #     #I18n.locale = params[:lang] || I18n.default_locale
  # end

  # def change_locale
  #      session[:lang] = params[:lang]
  #      redirect_back fallback_location: root_path
  # end

  # def locale_from_header
  #     locale = request.env.fetch('HTTP_ACCEPT_LANGUAGE', '').scan(/[a-z]{2}/).first
  #     I18n.locale_available?(locale) && locale
  # end

  around_action :switch_locale

  def switch_locale(&)
    params_locale = I18n.locale_available?(params[:lang]) && params[:lang]
      locale = params_locale || locale_from_header || I18n.default_locale
      I18n.with_locale(locale, &)
  end

  def locale_from_header
    locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
      I18n.locale_available?(locale) && locale
  end

  def default_url_options
    { lang: I18n.locale }
  end
end
