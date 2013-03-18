module ApplicationHelper
  def localized_model_name(klass, plural = false)
    key = plural ? :other : :one
    fallback = klass.model_name
    fallback = fallback.pluralize if plural
    I18n.t("activerecord.models.#{klass.model_name.i18n_key}.#{key}", :default => fallback.to_s).html_safe
  end

  def localized_attribute_name(klass, attribute)
    if klass.is_a?(Class) and klass.respond_to?(:human_attribute_name)
      klass.human_attribute_name(attribute).html_safe
    else
      attribute.to_s.titleize.html_safe
    end
  end

  def icon_tag(icon)
    content_tag :i, '', :class => icon
  end

  def markdown(text)
    engine = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :no_intra_emphasis => true, :tables => false)
    engine.render(text).html_safe
  end

  def options_for_locale_select
    locales =  {}
    I18n.available_locales.each do |l|
      l = l.to_s.sub('-', '_')
      trans = I18n.t("locales.#{l}", :default => '')

      if trans.blank?
        l, ext = l.split('_')
        trans = I18n.t("locales.#{l}") + " (#{ext})"
      end
      locales[ trans ] = l
    end

    locales.sort
  end

end
