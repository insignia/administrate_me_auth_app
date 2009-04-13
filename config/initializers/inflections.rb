# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format
# (all these examples are active by default):
# ActiveSupport::Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# Spanish inflections

# Add new inflection rules using the following format
# (all these examples are active by default):
ActiveSupport::Inflector.inflections do |inflect|
  inflect.clear :singulars
  inflect.plural( /([aeiou])$/i, '\1s' )
  inflect.plural( /(d|l|n|r)$/i, '\1es' )
  inflect.plural( /(m)$/i, '\1s' )
  english_words = %w{User Session Role Password ClientApplication OauthToken OauthClient}
  english_words.each do |word|
    inflect.plural( Regexp.new("\\b(#{word})$", true), '\1s')
    inflect.plural( Regexp.new("\\b(#{word.underscore})$", true), '\1s')
  end

  inflect.singular( /([aeiou])s$/i, '\1' )
  inflect.singular( /(d|l|n|r)es$/i, '\1')
  inflect.singular( /(m)s$/i, '\1')
  english_words.each do |word|
    inflect.singular( Regexp.new("\\b(#{word})s$", true), '\1')
    inflect.singular( Regexp.new("\\b(#{word.underscore})s$", true), '\1')
  end

end
