# set the load_path
I18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
# set default locale to something other than :en
I18n.default_locale = :es
# fallback to en when there is not translation
I18n.backend.class.send(:include, I18n::Backend::Fallbacks)
I18n.fallbacks.map('es' => 'en')
